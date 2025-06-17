@echo off

set GRADLE_DIR=%CD%\gradle_user_home

REM Create test directory if it doesn't exist
if not exist "%GRADLE_DIR%" mkdir "%GRADLE_DIR%"

set GRADLE_USER_HOME=%GRADLE_DIR%

echo === DEPENDENCY SETUP ===
gradlew.bat build --refresh-dependencies -q --continue -x spring-webmvc:test -x :spring-webflux:test -x checkstyleNohttp
gradlew.bat clean -q

echo === PERFORMANCE TESTING ===
echo Start time: %time%
gradlew.bat clean build -x spring-webmvc:test -x :spring-webflux:test -x checkstyleNohttp --rerun-tasks --offline --parallel
echo End time: %time%