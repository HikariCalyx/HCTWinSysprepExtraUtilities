@echo off

set tn_line_new=15
set tn_line_old=129


if %PROCESSOR_ARCHITECTURE% NEQ AMD64 goto x86

:x64
echo X64 Processor detected
cpuz_x64 -txt=output
goto vm_judgement

:x86
echo X86 Processor detected
cpuz_x32 -txt=output

:vm_judgement
findstr "VMware" output.txt >> vm.txt
findstr "VirtualBox" output.txt >> vm.txt
findstr /C:"Virtual Machine" output.txt >> vm.txt
findstr "Parallels" output.txt >> vm.txt
set /p vm_detect=<vm.txt
del vm.txt
if "%vm_detect%"=="" (echo This is not a virtual machine.) else goto vm_skip

:technology
findstr "Technology" output.txt > technology.txt
findstr "nm" technology.txt > tn.txt
del technology.txt
set /p technol=< tn.txt
del tn.txt
set "technol=%technol:	Technology		=%"
set "technol=%technol: nm=%"
echo %technol%
if %technol% gtr %tn_line_old% goto unsuitable
if %technol% lss %tn_line_new% goto unsuitable
if %technol% geq %tn_line_new% goto suitable
pause>nul

:unsuitable
if %technol% gtr %tn_line_old% pecmd mess This PC is too old to run Windows 7.\nLitography: %technol% nm.\nThe installation will be terminated in 15 seconds.@HCT Technology Detector *15000
if %technol% lss %tn_line_new% pecmd mess This PC is too new to run Windows 7.\nLitography: %technol% nm.\nThe installation will be terminated in 15 seconds.\n\nWe recommend you to install Windows 10 instead.@HCT Technology Detector *15000
rem add required command here
rem pecmd shut r
exit

:suitable
pecmd mess This PC can run Windows 7.\nLitography: %technol% nm.\n\nThe installation will proceed in 15 seconds.@HCT Technology Detector *15000
rem add required command here
exit

:vm_skip
pecmd mess Virtual Machine detected.\n\nThe installation will proceed in 15 seconds.@HCT Technology Detector *15000
rem add required command here
exit
