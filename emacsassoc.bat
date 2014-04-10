REM $Id: emacsassoc.bat,v 1.1 2003/01/10 08:21:27 reichr Exp $
REM You should adjust the path to gnuclientw.exe
REM %%1 is needed for 4nt, %1 can be used for cmd.exe

ftype emacs-file=C:\bin\emacs-24.3\bin\emacsclientw.exe -a C:\bin\emacs-23.3\bin\runemacs.exe "%1"
assoc .vhdl=emacs-file
assoc .vhd=emacs-file
assoc .v=emacs-file
assoc .c=emacs-file
assoc .txt=emacs-file
assoc .el=emacs-file
assoc .pl=emacs-file
assoc .pm=emacs-file
assoc .tex=emacs-file
assoc .rb=emacs-file