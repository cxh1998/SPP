@set FPGA_PATH=fpgajic\fpga
@set ROM_PATH=.
@set MV_PATCH=mv\src\yichip
@set YC_PATCH_FILE=yc_patch_yc1021.h
@set enc=1
@set enckey=0000000000000000
@echo off
setlocal enabledelayedexpansion

copy patch\patch.prog output\bt_program23.meta
copy rom\rom.format + rom\app_module.format + rom\label.format + patch\patch.format + rom\command.format output\bt_format.meta
perl util/mergepatch.pl output/bt_program23.meta
perl util/memalloc.pl output/bt_format.meta
cd output
osiuasm bt_program23 -O-W


  copy ..\sched\DM_module.dat + ..\sched\109x.dat ..\output\sched.rom

  
if "%1" equ "eep" (
	goto genromrevc
)else (
  goto downloadram
)



:genromrevc
@echo Start to generate EEPROM code

..\util\geneep -n ramcode.rom sched.rom 0 %enckey% c

 rem geneep -n -k key.txt

cd ..\output

echo eeprom.dat Generated......


perl ..\util\eeprom2hciimage_1021s.pl
echo bt_patch.bin Generated......
perl ..\util\bin2array.pl > bt_patch.h
echo bt_patch.h Generated......



goto end



:downloadram
echo on
@echo Start to download ram code
e ku
e hu
e su sched.rom
@echo **********************************
@echo RAM CODE has been downloaded.
@echo The Device is %device_option%. 
@echo **********************************
cd ..


:end
