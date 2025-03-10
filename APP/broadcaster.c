/********************************** (C) COPYRIGHT *******************************
 * File Name          : broadcaster.c
 * Author             : WCH
 * Version            : V1.0
 * Date               : 2020/08/06
 * Description        : 广播应用程序，初始化广播连接参数，然后处于广播态一直广播

 *********************************************************************************
 * Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
 * Attention: This software (modified or not) and binary are used for
 * microcontroller manufactured by Nanjing Qinheng Microelectronics.
 *******************************************************************************/

#include "CONFIG.h"
#include "devinfoservice.h"
#include "broadcaster.h"
#include "app_i2c.h"

// 广播间隔 (units of 625us, min is 160=100ms)
#define DEFAULT_ADVERTISING_INTERVAL 1600 * 2
// 采集间隔
#define SBP_PERIODIC_EVT_PERIOD 1600 * 20

// ADC 采样粗调偏差值
static signed short RoughCalib_Value = 0;
// 电池电压
static uint16_t bat = 0;

uint16_t DEFAULT_COMPENSATION_RH = 0x8000;  // in ticks as defined by SGP41
uint16_t DEFAULT_COMPENSATION_T = 0x6666;   // in ticks as defined by SGP41

// Task ID for internal task/event processing
static uint8_t Broadcaster_TaskID;

// 广播数据 (包含UUID和测量数据)
static uint8_t advertData[] = {
    0x02, GAP_ADTYPE_FLAGS, GAP_ADTYPE_FLAGS_GENERAL | GAP_ADTYPE_FLAGS_BREDR_NOT_SUPPORTED,//0-2
 //   0x12  , 0x09, 0x54, 0x26, 0x48, 0x20, 0x4D, 0x65, 0x74, 0x65, 0x72, 0x20, 0x35, 0x42, 0x72, 0x65, 0x65, 0x7A, 0x65,//设备名称：T&H Meter 5Breeze 3-21
    0x0C, 0x16, 0xD2, 0xFC, // 长度、AD类型、UUID (BTHome UUID FCD2) 3-6
    0x40,                   // BTHome v2 无加密，定期广播 7
    0x01, 0x00,             // 电量 (占位符) 8-9
    0x02, 0x00, 0x00,       // 温度 (占位符) 10-12
    0x03, 0x00, 0x00        // 湿度 (占位符) 13-15
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static void Broadcaster_ProcessTMOSMsg(tmos_event_hdr_t* pMsg);
static void Broadcaster_StateNotificationCB(gapRole_States_t newState);
extern bStatus_t GAP_UpdateAdvertisingData(uint8_t taskID, uint8_t adType, uint16_t dataLen, uint8_t* pAdvertData);




/*
 * Get the humidity and temperature values to use for compensating SGP41
 * measurement values. The returned humidity and temperature is in ticks
 * as defined by SGP41 interface.
 *
 * @param compensation_rh: out variable for humidity
 * @param compensation_t: out variable for temperature
 */

int16_t local_error = 0;
    uint16_t temperature_ticks = 0;
    uint16_t humidity_ticks = 0;
    local_error =
        sht4x_measure_high_precision_ticks(&temperature_ticks, &humidity_ticks);
    CHECK_EQUAL_ZERO_TEXT(local_error, "measure_high_precision_ticks");
    printf("temperature_ticks: %u ", temperature_ticks);
    printf("humidity_ticks: %u\n", humidity_ticks);


void read_compensation_values(uint16_t* compensation_rh,
                              uint16_t* compensation_t) {
    int16_t error = 0;
    float s_rh = 0;
    float s_temperature = 0;
    error = sht4x_measure_high_precision(&s_temperature, &s_rh);
    if (error) {

        *compensation_rh = DEFAULT_COMPENSATION_RH;
        *compensation_t = DEFAULT_COMPENSATION_T;
    } else {
        *compensation_rh = (uint16_t)(s_rh * 65535 / 100);
        *compensation_t = (uint16_t)((s_temperature + 45) * 65535 / 175);
    }
}


/*********************************************************************
 * PROFILE CALLBACKS
 */

// GAP Role Callbacks
static gapRolesBroadcasterCBs_t Broadcaster_BroadcasterCBs = {
    Broadcaster_StateNotificationCB, // Profile State Change Callbacks
    NULL
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

// 电池电压采样
__HIGH_CODE
uint16_t sample_battery_voltage()
{
    // VINA 实际电压值 1050±15mV
    const int vref = 1050;

    ADC_InterBATSampInit();

    // 每200次进行一次粗调校准
    static uint8_t calib_count = 0;
    calib_count++;
    if (calib_count == 1) {
        RoughCalib_Value = ADC_DataCalib_Rough();
    }
    calib_count %= 200;

    ADC_ChannelCfg(CH_INTE_VBAT);
    return (ADC_ExcutSingleConver() + RoughCalib_Value) * vref / 512 - 3 * vref;
}

// SHT4x 读取温湿度
// 模式: low    med    high
// 湿度: 0.25%  0.15%  0.08%
// 温度: 0.1C   0.07C  0.04C
// 耗时: 1.6ms  4.5ms  8.3ms
// CMD: 0xE0   0xF6   0xFD
__HIGH_CODE
int read_sht4x_data(float* temperature, float* humidity)
{
    i2c_app_init(0x01);
    const uint8_t cmd = 0xE0;
    int ret = i2c_write_to(0x44, &cmd, sizeof(cmd), true, true);
    DelayMs(2);
    uint8_t rx_bytes[6];
    ret = i2c_read_from(0x44, rx_bytes, 6, true, 100);
    if (ret != 6) return 0;

    uint32_t temp_raw = ((uint32_t)rx_bytes[0] << 8) | rx_bytes[1];
    uint32_t humid_raw = ((uint32_t)rx_bytes[3] << 8) | rx_bytes[4];

    float temp_f = -45.0 + 175.0 * temp_raw / 65535.0;
    float humid_f = -6.0 + 125.0 * humid_raw / 65535.0;
    humid_f = (humid_f > 100.0f) ? 100.0f : humid_f;
    humid_f = (humid_f < 0.0f) ? 0.0f : humid_f;

    *temperature = temp_f;
    *humidity = humid_f;

    return 1;
}


//void update_advert_data()
//{
//    // 广播设备名称在 advertData 的位置
//    const uint8_t name_index = 5;
//    // 广播设备名称长度
//    const uint8_t name_len = sizeof(advertData) - name_index;
//
//    // 清空广播设备名称
//    memset(advertData + name_index, 0x00, name_len);
//
//    // 读取温湿度
//    float temp, humid;
//    int sht4x_ret = read_sht4x_data(&temp, &humid);
//
//    // 读取电池电压
//    bat = sample_battery_voltage();
//
//    // 更新广播设备名称
//    if (sht4x_ret) {
//        snprintf(advertData + name_index, name_len, "%.2fV/%.2fC/%.2f%%", bat / 1000.0f, temp, humid);
//    } else {
//        snprintf(advertData + name_index, name_len, "%.2fV/ERR/ERR", bat / 1000.0f);
//    }
//}



__HIGH_CODE
void read_sensor_data() {
int16_t error = 0;
uint16_t nox_conditioning_s = 10;
uint16_t compensation_rh = DEFAULT_COMPENSATION_RH;
uint16_t compensation_t = DEFAULT_COMPENSATION_T;
uint16_t sraw_voc = 0;
uint16_t sraw_nox = 0;
int32_t voc_index_value = 0;
int32_t nox_index_value = 0;
uint16_t serial_number[3];

error = sgp41_get_serial_number(serial_number);
if (error) {
  PRINT("Error executing sgp41_get_serial_number(): %i\n", error);
} else {
  PRINT("serial: 0x%04x%04x%04x\n", serial_number[0], serial_number[1],
           serial_number[2]);
}

uint16_t test_result;

error = sgp41_execute_self_test(&test_result);
if (error) {
  PRINT("Error executing sgp41_execute_self_test(): %i\n", error);
} else {
  PRINT("Test result: %u\n", test_result);
}


// initialize gas index parameters
GasIndexAlgorithmParams voc_params;
GasIndexAlgorithm_init(&voc_params, GasIndexAlgorithm_ALGORITHM_TYPE_VOC);
GasIndexAlgorithmParams nox_params;
GasIndexAlgorithm_init(&nox_params, GasIndexAlgorithm_ALGORITHM_TYPE_NOX);

// initialize i2c communication used for SHT4x and SGP41
sensirion_i2c_hal_init();

for (int i = 0; i < 100; i += 1) {

    // 1. Sleep: Measure every second (1Hz), as defined by the Gas Index
    // Algorithm prerequisite
    sensirion_i2c_hal_sleep_usec(1000000);

    // 2. Measure SHT4x  RH and T signals and convert to SGP41 ticks
    read_compensation_values(&compensation_rh, &compensation_t);

    // 3. Measure SGP4x signals
    if (nox_conditioning_s > 0) {
        // During NOx conditioning (10s) SRAW NOx will remain 0
        error = sgp41_execute_conditioning(compensation_rh, compensation_t,
                                           &sraw_voc);
        nox_conditioning_s--;
        PRINT("NOx conditioning remaining time: %i s\n",
               nox_conditioning_s);
    } else {
        error = sgp41_measure_raw_signals(compensation_rh, compensation_t,
                                          &sraw_voc, &sraw_nox);
    }

    // 4. Process raw signals by Gas Index Algorithm to get the VOC and NOx
    // index values
    if (error) {
      PRINT("Error executing sgp41_measure_raw_signals(): %i\n", error);
    } else {
        GasIndexAlgorithm_process(&voc_params, sraw_voc, &voc_index_value);
        GasIndexAlgorithm_process(&nox_params, sraw_nox, &nox_index_value);
        PRINT("VOC Raw: %i\tVOC Index: %i\n", sraw_voc, voc_index_value);
        PRINT("NOx Raw: %i\tNOx Index: %i\n", sraw_nox, nox_index_value);
    }
}
}

__HIGH_CODE
void update_advert_data() {
    // 读取温湿度
    float temp, humid;
    uint8_t BL_bat;
    int sht4x_ret = read_sht4x_data(&temp, &humid);

    // 读取电池电压
    bat = sample_battery_voltage();
    BL_bat = (uint8_t)((bat-2500)/8);
    if (BL_bat > 100)
        BL_bat =100;
    // 更新广播包中的电量数据
    advertData[9] = BL_bat; // 电量百分比

    if (sht4x_ret) {
        // 更新温度数据
        int16_t temp_data = (int16_t)(temp * 100); // 放大100倍为整数
        advertData[11] = temp_data & 0xFF; // 温度低字节
        advertData[12] = (temp_data >> 8) & 0xFF; // 温度高字节

        // 更新湿度数据
        uint16_t humid_data = (uint16_t)(humid * 100); // 放大100倍为整数
        advertData[14] = humid_data & 0xFF; // 湿度低字节
        advertData[15] = (humid_data >> 8) & 0xFF; // 湿度高字节
    } else {
        // 数据错误，填充默认值
        advertData[9] = 0xFF; // 错误标志
        advertData[11] = 0xFF; // 错误标志
        advertData[12] = 0xFF; // 错误标志
        advertData[14] = 0xFF; // 错误标志
        advertData[15] = 0xFF; // 错误标志
    }
    read_sensor_data();
}



/*********************************************************************
 * @fn      Broadcaster_Init
 *
 * @brief   Initialization function for the Broadcaster App
 *          Task. This is called during initialization and should contain
 *          any application specific initialization (ie. hardware
 *          initialization/setup, table initialization, power up
 *          notificaiton ... ).
 *
 * @param   task_id - the ID assigned by TMOS.  This ID should be
 *                    used to send messages and set timers.
 *
 * @return  none
 */
void Broadcaster_Init()
{
    Broadcaster_TaskID = TMOS_ProcessEventRegister(Broadcaster_ProcessEvent);

    // Setup the GAP Broadcaster Role Profile
    {
        // Device starts advertising upon initialization
        uint8_t initial_advertising_enable = TRUE;
        uint8_t initial_adv_event_type = GAP_ADTYPE_ADV_NONCONN_IND;
        // uint8_t initial_adv_event_type = GAP_ADTYPE_ADV_IND;
        // uint8_t initial_adv_event_type = GAP_ADTYPE_EXT_NONCONN_NONSCAN_UNDIRECT;

        // Set the GAP Role Parameters
        GAPRole_SetParameter(GAPROLE_ADVERT_ENABLED, sizeof(uint8_t), &initial_advertising_enable);
        GAPRole_SetParameter(GAPROLE_ADV_EVENT_TYPE, sizeof(uint8_t), &initial_adv_event_type);
        GAPRole_SetParameter(GAPROLE_ADVERT_DATA, sizeof(advertData), advertData);
    }

    // Set advertising interval
    {
        uint16_t advInt = DEFAULT_ADVERTISING_INTERVAL;

        GAP_SetParamValue(TGAP_DISC_ADV_INT_MIN, advInt);
        GAP_SetParamValue(TGAP_DISC_ADV_INT_MAX, advInt);

        // GAP_SetParamValue(TGAP_ADV_SECONDARY_PHY, GAP_PHY_VAL_LE_CODED); // 125K
        // GAP_SetParamValue(TGAP_ADV_PRIMARY_PHY, GAP_PHY_VAL_LE_CODED); // 125K
    }

    // Setup a delayed profile startup
    // tmos_set_event(Broadcaster_TaskID, SBP_START_DEVICE_EVT);
    tmos_start_task(Broadcaster_TaskID, SBP_START_DEVICE_EVT, DEFAULT_ADVERTISING_INTERVAL);

    // 设置定时读取传感器并更新广播
    tmos_start_task(Broadcaster_TaskID, SBP_PERIODIC_EVT, 2 * DEFAULT_ADVERTISING_INTERVAL - 320);
}

/*********************************************************************
 * @fn      Broadcaster_ProcessEvent
 *
 * @brief   Broadcaster Application Task event processor. This
 *          function is called to process all events for the task. Events
 *          include timers, messages and any other user defined events.
 *
 * @param   task_id  - The TMOS assigned task ID.
 * @param   events - events to process.  This is a bit map and can
 *                   contain more than one event.
 *
 * @return  events not processed
 */
uint16_t Broadcaster_ProcessEvent(uint8_t task_id, uint16_t events)
{
    if (events & SYS_EVENT_MSG) {
        uint8_t* pMsg;

        if ((pMsg = tmos_msg_receive(Broadcaster_TaskID)) != NULL) {
            Broadcaster_ProcessTMOSMsg((tmos_event_hdr_t*)pMsg);

            // Release the TMOS message
            tmos_msg_deallocate(pMsg);
        }

        // return unprocessed events
        return (events ^ SYS_EVENT_MSG);
    }

    if (events & SBP_START_DEVICE_EVT) {
        // Start the Device
        GAPRole_BroadcasterStartDevice(&Broadcaster_BroadcasterCBs);

        return (events ^ SBP_START_DEVICE_EVT);
    }

    if (events & SBP_PERIODIC_EVT) {
        tmos_start_task(Broadcaster_TaskID, SBP_PERIODIC_EVT, SBP_PERIODIC_EVT_PERIOD);

        // 数据采集并更新广播
        update_advert_data();
        GAP_UpdateAdvertisingData(0, TRUE, sizeof(advertData), advertData);

        return (events ^ SBP_PERIODIC_EVT);
    }

    // Discard unknown events
    return 0;
}

/*********************************************************************
 * @fn      Broadcaster_ProcessTMOSMsg
 *
 * @brief   Process an incoming task message.
 *
 * @param   pMsg - message to process
 *
 * @return  none
 */
static void Broadcaster_ProcessTMOSMsg(tmos_event_hdr_t* pMsg)
{
    switch (pMsg->event) {
    default:
        break;
    }
}

/*********************************************************************
 * @fn      Broadcaster_StateNotificationCB
 *
 * @brief   Notification from the profile of a state change.
 *
 * @param   newState - new state
 *
 * @return  none
 */
static void Broadcaster_StateNotificationCB(gapRole_States_t newState)
{
    switch (newState) {
    case GAPROLE_STARTED:
        PRINT("Initialized..\n");
        break;

    case GAPROLE_ADVERTISING:
        PRINT("Advertising..\n");
        break;

    case GAPROLE_WAITING:
        PRINT("Waiting for advertising..\n");
        break;

    case GAPROLE_ERROR:
        PRINT("Error..\n");
        break;

    default:
        break;
    }
}
