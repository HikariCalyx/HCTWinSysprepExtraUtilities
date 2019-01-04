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
findstr "VMware" output.txt > vm.txt
findstr "VirtualBox" output.txt > vm.txt
findstr "Virtual Machine" output.txt > vm.txt
findstr "Parallels" output.txt > vm.txt
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
if %technol% gtr %tn_line_old% pecmd mess 此计算机因为年代久远，不适合运行 Windows 7。\n制程 %technol% nm。\n15 秒后安装程序将强行终止。@HCT 制程判断程序 *10000
if %technol% lss %tn_line_new% pecmd mess 此计算机因为太新了，不适合运行 Windows 7。\n制程 %technol% nm。\n15 秒后安装程序将强行终止。\n\n我们建议您在此机器安装 Windows 10 使用。@HCT 制程判断程序 *10000
rem add required command here
pecmd shut r
exit

:suitable
pecmd mess 此计算机可以运行 Windows 7。\n制程 %technol% nm。\n\n15 秒后安装程序将继续。@HCT 制程判断程序 *10000
rem add required command here
exit

:vm_skip
pecmd mess 检测到虚拟机。\n\n15 秒后安装程序将继续。@HCT 制程判断程序 *10000
rem add required command here
exit
