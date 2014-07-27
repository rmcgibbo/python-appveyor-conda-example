xcopy /e "%RECIPE_DIR%\.." "%SRC_DIR%"
dir "%SRC_DIR%"
"%PYTHON%" setup.py install
if errorlevel 1 exit 1