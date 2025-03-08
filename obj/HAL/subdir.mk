################################################################################
# MRS Version: 1.9.2
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../HAL/MCU.c \
../HAL/RTC.c \
../HAL/SLEEP.c \
../HAL/algorithm_example_usage.c \
../HAL/sensirion_common.c \
../HAL/sensirion_gas_index_algorithm.c \
../HAL/sensirion_i2c.c \
../HAL/sensirion_i2c_hal.c \
../HAL/sgp41_i2c.c \
../HAL/sht4x_i2c.c 

OBJS += \
./HAL/MCU.o \
./HAL/RTC.o \
./HAL/SLEEP.o \
./HAL/algorithm_example_usage.o \
./HAL/sensirion_common.o \
./HAL/sensirion_gas_index_algorithm.o \
./HAL/sensirion_i2c.o \
./HAL/sensirion_i2c_hal.o \
./HAL/sgp41_i2c.o \
./HAL/sht4x_i2c.o 

C_DEPS += \
./HAL/MCU.d \
./HAL/RTC.d \
./HAL/SLEEP.d \
./HAL/algorithm_example_usage.d \
./HAL/sensirion_common.d \
./HAL/sensirion_gas_index_algorithm.d \
./HAL/sensirion_i2c.d \
./HAL/sensirion_i2c_hal.d \
./HAL/sgp41_i2c.d \
./HAL/sht4x_i2c.d 


# Each subdirectory must supply rules for building sources it contributes
HAL/MCU.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/MCU.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/RTC.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/RTC.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/SLEEP.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/SLEEP.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/algorithm_example_usage.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/algorithm_example_usage.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sensirion_common.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sensirion_common.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sensirion_gas_index_algorithm.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sensirion_gas_index_algorithm.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sensirion_i2c.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sensirion_i2c.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sensirion_i2c_hal.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sensirion_i2c_hal.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sgp41_i2c.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sgp41_i2c.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/sht4x_i2c.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/HAL/sht4x_i2c.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

