################################################################################
# MRS Version: 1.9.2
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../RVMSIS/core_riscv.c 

OBJS += \
./RVMSIS/core_riscv.o 

C_DEPS += \
./RVMSIS/core_riscv.d 


# Each subdirectory must supply rules for building sources it contributes
RVMSIS/core_riscv.o: C:/Users/bitshen/Desktop/SGP41/SGP41-CH59x/RVMSIS/core_riscv.c
	@	@	riscv-none-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DCLK_OSC32K=0 -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Startup" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\APP\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Profile\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\StdPeriphDriver\inc" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\HAL\include" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\Ld" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\LIB" -I"C:\Users\bitshen\Desktop\SGP41\SGP41-CH59x\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

