@rem This file creates the distribution EmacsW32-nn.exe file.
@rem (Created by EmacsW32 at Fri Aug  2 09:27:13 2013)
"C:\Program Files (x86)\Inno Setup 5\ISCC.exe" %0\..\EmacsW32.iss
if %ERRORLEVEL% LEQ 1 start %0\..\Output\EmacsW32-alone-1.58.exe
