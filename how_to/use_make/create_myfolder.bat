@mkdir myfolder

:: go to folder
@cd myfolder

:: creates 3 files named from  file-1.txt, file-3.txt, file-5.txt . From 1 , with a step of 2 until 6. *
@for /L %%n in (1 2 6) do (type nul > file-%%n.txt)

:: leave this folder
@cd ..