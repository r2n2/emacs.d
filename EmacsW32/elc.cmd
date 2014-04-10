@rem Recompiles .el files given. Wildcard allowed.
@rem (Created by Setup Helper at Fri Aug  2 09:27:13 2013)
for %%f in (%*) do c:\bin\emacs\bin\emacs.exe -batch -Q -L ./ -f batch-byte-compile %%f
