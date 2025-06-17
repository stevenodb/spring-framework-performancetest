@echo off

set GRADLE_DIR=%CD%\gradle_user_home

REM Create directory if it doesn't exist
if not exist "%GRADLE_DIR%" mkdir "%GRADLE_DIR%"

set GRADLE_USER_HOME=%GRADLE_DIR%

echo === DEPENDENCY SETUP ===
REM One-time full build to download dependencies
CALL gradlew.bat build --refresh-dependencies -q --continue -x :spring-webflux:test -x :spring-webmvc:test -x checkstyleNohttp || echo Dependency setup completed with some failures
CALL gradlew.bat clean

echo === PERFORMANCE TESTING ===
CALL powershell -Command "Measure-Command { .\gradlew.bat clean build -x :spring-webflux:test -x :spring-webmvc:test -x checkstyleNohttp --rerun-tasks --offline --parallel } | Select-Object TotalMinutes"