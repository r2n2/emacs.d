@rem (Created by Setup Helper at Fri Aug  2 09:27:13 2013)
@echo.
@echo   This creates a new distribution Emacs-24-DISTRIBID-emacsw32-1.58.exe file.
@echo   The .exe file will include YOUR current Emacs tree, that is
@echo   everything in "c:\bin\emacs-24.3\".
@echo.
@echo   Your are encourage to only keep the core Emacs dist there.
@echo   If you want to include other files you may edit the script file
@echo   before your create the installation package.
@echo.

@if not "%1"=="" goto mk-iss

@c:\bin\emacs\bin\emacs.exe -batch -Q -eval  "(unless (y-or-n-p \"You will be prompted for DISTRIBID (since you did not give it as a parameter).\nDo you want to continue? \") (kill-emacs 1))
@if %errorlevel% GTR 0 exit /b %errorlevel%

:mk-iss
@if exist %0\..\temp-installer.iss del %0\..\temp-installer.iss
@c:\bin\emacs\bin\emacs.exe -batch -Q -l %0\..\lisp\mkInstaller.el --eval="(mkInstaller-create-iss \"%1\" \"%2\")"
@if %errorlevel% GTR 0 exit /b %errorlevel%

@if not "%1"=="" goto run

@echo.
@c:\bin\emacs\bin\emacs.exe -batch -Q -eval  "(unless (y-or-n-p \"Do you want to run the Inno script above to create the .exe? \") (kill-emacs 1))
@if %errorlevel% GTR 0 goto fin

@c:\bin\emacs\bin\emacs.exe -batch -Q -eval  "(unless (y-or-n-p \"Do you want to start Inno Setup first to edit the script? \") (kill-emacs 1))
@if %errorlevel% GTR 0 goto run

@start %0\..\temp-installer.iss
@goto fin

:run
"C:\Program Files (x86)\Inno Setup 5\ISCC.exe" %0\..\temp-installer.iss

:fin
