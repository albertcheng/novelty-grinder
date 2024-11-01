@echo off
REM
REM Copyright 2024 Sami Kiminki
REM
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM
REM     http://www.apache.org/licenses/LICENSE-2.0
REM
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.
REM

REM Shell wrapper to invoke novelty grinder in the Python virtual
REM environment.

setlocal
set SRCDIR=%~dp0
set PYTHON3=%SRCDIR%python-venv\Scripts\python.exe

if not exist "%PYTHON3%" (
    echo Cannot access %PYTHON3%. Try running:
    echo     %SRCDIR%setup-python-venv.cmd
    exit /b 1
)

"%PYTHON3%" "%SRCDIR%src\noveltygrinder.py" %*
