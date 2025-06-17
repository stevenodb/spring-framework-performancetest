@echo off

set GRADLE_DIR=%CD%\gradle_user_home

if not exist "%GRADLE_DIR%" mkdir "%GRADLE_DIR%"

set GRADLE_USER_HOME=%GRADLE_DIR%

echo.
echo === DEPENDENCY SETUP ===
echo.
REM One-time full build to download dependencies
gradlew.bat build --refresh-dependencies -q --continue -x :spring-webflux:test -x :spring-webmvc:test -x checkstyleNohttp
gradlew.bat clean -q

echo.
echo === PERFORMANCE TESTING ===
echo Start time: %time%
echo.
gradlew.bat clean build -x :spring-webflux:test -x :spring-webmvc:test -x checkstyleNohttp --rerun-tasks --offline --parallel
echo.
echo End time: %time%