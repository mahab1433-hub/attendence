@echo off
echo Building Smart Attendance APK...
echo.

REM Set JAVA_HOME to use Java 21
set JAVA_HOME=C:\Program Files\Java\jdk-21

REM Clear Gradle cache
echo Clearing Gradle cache...
cd temp_smart_attendance
flutter clean
flutter pub get

REM Try building with different parameters
echo Attempting APK build...
flutter build apk --release --no-shrink --target-platform android-arm64

REM If that fails, try debug build
if %ERRORLEVEL% neq 0 (
    echo Release build failed, trying debug build...
    flutter build apk --debug --target-platform android-arm64
)

REM Check if APK was created
if exist "build\app\outputs\flutter-apk\*.apk" (
    echo.
    echo SUCCESS! APK file created:
    dir build\app\outputs\flutter-apk\*.apk
    echo.
    echo APK location: %CD%\build\app\outputs\flutter-apk\
) else (
    echo.
    echo APK build failed. Try running this in Android Studio instead.
)

pause
