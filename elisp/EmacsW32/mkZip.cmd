@rem This file creates the distribution zip file.
@rem (Created by EmacsW32 at Fri Aug  2 09:27:13 2013)
pushd %0\..\..
@if exist EmacsW32\mkZip.lst del EmacsW32\mkZip.lst
@emacs.exe -batch -Q -l EmacsW32/lisp/mkZipLst.el
@if not exist EmacsW32\Output mkdir EmacsW32\Output
@if exist EmacsW32\Output\EmacsW32-alone-1.58.zip del EmacsW32\Output\EmacsW32-alone-1.58.zip
EmacsW32\bin\7za.exe a -tzip EmacsW32\Output\EmacsW32-alone-1.58.zip @EmacsW32\mkZip.lst
popd
