@ECHO OFF
REM Batch file to automatically build all scss files in a directory into css files
REM Usage:
REM buildcss [inputpath] [outputpath] [style]
REM Style can be nested, expanded, compact and compressed

IF NOT EXIST %~dp0sassc.exe (
    ECHO Error: sassc.exe not found in directory
    GOTO :EOF
)

IF NOT EXIST %~f1 (
    ECHO Error: Input path invalid
    GOTO :USAGE
)

IF NOT EXIST %~f2 (
    ECHO Error: Output path invalid
    GOTO :USAGE
)

FOR %%G IN (
    "nested"
    "expanded"
    "compact"
    "compressed") DO (
        IF /I "%3" == "%%~G" GOTO :BUILD
    ) 

ECHO Style parameter incorrect
GOTO :USAGE

:BUILD
ECHO Building...
FOR /f %%F IN ('dir /b %~f1') DO (
    ECHO Building %%~nxF
    CALL %~dp0sassc.exe -t %3 "%~f1\/%%~nxF" "%~f2\/%%~nF.css"
)
ECHO Done.
GOTO :EOF

:USAGE
ECHO Usage: buildcss [inputpath] [outputpath] [style]
ECHO Style can be 'nested', 'expanded', 'compact' or 'compressed'
GOTO :EOF