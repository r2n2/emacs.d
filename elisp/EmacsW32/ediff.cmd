@rem Put this file (ediff.cmd) in your PATH.
@rem (Created by Setup Helper at Fri Aug  2 09:27:13 2013)
@rem -----------------------------
@rem Starts Emacs ediff (through emacsclient) from command line.
@rem Takes the two file to compare as parameters.
@setlocal
@set f1=%1
@set f2=%2
@set f1=%f1:\=/%
@set f2=%f2:\=/%
@set emacs_cd=%CD:\=/%
@set emacs_client="c:\bin\emacs-24.3\bin\emacsclient.exe"
@%emacs_client% -n
@%emacs_client% -e "(setq default-directory \"%emacs_cd%\")"
@%emacs_client% -n  -e "(ediff-files \"%f1%\" \"%f2%\")"
