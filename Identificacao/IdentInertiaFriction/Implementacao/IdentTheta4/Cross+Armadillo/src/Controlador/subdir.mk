################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/Controlador/CONTROL_LQR.cpp 

OBJS += \
./src/Controlador/CONTROL_LQR.o 

CPP_DEPS += \
./src/Controlador/CONTROL_LQR.d 


# Each subdirectory must supply rules for building sources it contributes
src/Controlador/%.o: ../src/Controlador/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	arm-linux-gnueabihf-g++ -DARMA_DONT_USE_WRAPPER -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


