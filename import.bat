@ECHO OFF
ECHO IMPORT SAVE GAME FILES.
ECHO ------------------------
ECHO Game: Kao The Kangaroo 2022
ECHO Version: GOG
ECHO ------------------------
ECHO Select your option:
ECHO [1] - Import all save files from your current backup files (including Setting files).
ECHO [2] - Import only save game files.
ECHO [3] - Export save game files.
ECHO [0] - Exit

SET SOURCE_FILE=%cd%\KaoGOG
SET DEST_FILE=%LOCALAPPDATA%\KaoGOG
SET EXTENSION_SAVED_DIR=\Saved\SaveGames
SET SAVED_BACKUP_FILE=%SOURCE_FILE%%EXTENSION_SAVED_DIR%
SET SAVED_DEST_FILE=%DEST_FILE%%EXTENSION_SAVED_DIR%

SETLOCAL ENABLEDELAYEDEXPANSION
:LOOP_CHOICE
    SET /p USER_CHOICE=">> "
    @REM ECHO IT IS %USER_CHOICE%

    IF %USER_CHOICE% EQU 1 (

        IF NOT EXIST "%DEST_FILE%\" (
            MKDIR %DEST_FILE%
        )
        XCOPY "%SOURCE_FILE%" "%LOCALAPPDATA%\KaoGOG" /s/y
    
    ) ELSE IF %USER_CHOICE% EQU 2 (
        IF NOT EXIST "%DEST_FILE%\Saved" (
            ECHO DESTINATION FILE NOT FOUND.
            ECHO RUN THE GAME FIRST AND IMPORT SAVE GAME FILES AFTERWARDS.
        ) ELSE (
            IF NOT EXIST "%SAVED_DEST_FILE%\" (
                MKDIR "%SAVED_DEST_FILE%"
            )
            XCOPY "%SAVED_BACKUP_FILE%" "%SAVED_DEST_FILE%" /s/y
        )

    ) ELSE IF %USER_CHOICE% EQU 3 (
        IF NOT EXIST "%SAVED_DEST_FILE%" (
            ECHO NO SAVE FILES FOUND.
        ) ELSE (
            IF NOT EXIST "%SAVED_BACKUP_FILE%\" (
                MKDIR "%SAVED_BACKUP_FILE%"
            )
            
            SET COUNT=0
            FOR /F %%I IN ('DIR /b /a "%SAVED_DEST_FILE%"') DO (
                SET /A COUNT= COUNT+1
                ECHO [!COUNT!] %%I

                XCOPY "%SAVED_DEST_FILE%\%%I" "%SAVED_BACKUP_FILE%\%%I*" /y

            )
            @REM ECHO --------------------------------------- 
            @REM ECHO PLEASE SELECT FILE TO EXPORT BY NUMBER
            @REM ECHO OR TYPING [A] FOR EXPORTING ALL FILES 
            @REM ECHO ---------------------------------------
            @REM SET /P FILE_CHOOSE=">>> "
            @REM IF !FILE_CHOOSE! LSS 1 (
            @REM     !FILE_CHOOSE! GTR !COUNT! (
            @REM         ECHO OK
            @REM     )
            @REM )
        )
    )


    IF NOT %USER_CHOICE% EQU 0 GOTO LOOP_CHOICE


PAUSE