# Intro
To begin with, I want to make it clear that I am using a Windows machine so for a Mac user some commands might not work as expected.

# Instalation
Run `make --v` to see if you have it. Something like GNU Make 4.3 will show up, confirming you have it installed correctly

If no good result then you need to install it. The most simple choice is using Chocolatey package manager that you will nee to need to install if you don't have it, from https://chocolatey.org/install. 

Once installed you simlpy need to install `make` (you may need to run it in an elevated/admin command prompt) :

```
choco install make
```

Visual Studio has its own 'make' tool, `nmake`, check https://learn.microsoft.com/en-us/cpp/build/reference/nmake-reference. 
Can be used from the VS command prompt, but also you can add it to the bath as any other program. 
However, it has less functionalities than the GNU make.

# Start using it:
Navigate to your folder and create the file 
```
echo > "test.make"
```
Inspect the directory to see the file being created using `dir` command
Something like this will show up:
```
10/03/2023  12:39    <DIR>          .
10/03/2023  12:34    <DIR>          ..
10/03/2023  12:39                13 test.make
               1 File(s)             13 bytes
               2 Dir(s)  147,888,943,104 bytes free
```
For example, if you have already git installed, just type the path of the nano compiler and then the name of your file
"c:\Program Files\Git\usr\bin\nano.exe" <filename>

I suggest to use a proper text editor, such as Notepad++ or VSC to edit the files.

# Editing the Make file
Please note that I will show my try, with a few errors before making it right, to show things to avoid.

Now we will add something very basic to our file, like:
```
say_hello:
        echo "Hello World"
```
*to exit with saving, CRTL+X and choose Y and make sure the text. Also make sure that `say_hello` has no space before


I added, by mistake, an extension `.make`, so my file was `test.make`
After running `test.make ` like:
```
C:\HowToUseMake>test.make
```
I got the error:
`make: *** No targets specified and no makefile found.  Stop.`

Just remove the extension by renaming the file `test`, runned it again but I still got the error so I renamed the file to be `Makefile`

Then I just ran the command `make` and TA DA, we have a successful run! :)

echo "Hello World"\
"Hello World"

If we don’t have to call our Makefile Makefil, we call it something else we need to tell Make where to find it. This we can do using -f flag. For example, if our Makefile is named NewMakefile we would run:
make -f NewMakefile

But we want only the text to show up and suppress echoing the actual command, so we need to add @ in front of the echo command, like:
```
say_hello:
        @echo "Hello World"`
```
The terminal will display only "Hello World".

In the example above, `say_hello` behaves pretty much as in vba or workflows and is called `target`. The bit `echo "Hello World"` (the command, actually) is called `command` (or action). 


Now it's time to introduce `prerequisites` which adds the ability to create modular code.

Prerequisites(or dependencies) in the below example is `say_hello_morning` which tells the program to say first "Good morning World" and then "Nice to see you"
```
say_hello: say_hello_morning
	@echo "Nice to see you"
say_hello_morning: 
	@echo "Good morning World"
```

You can add multiple prerequisites, like:
```
say_hello: say_hello_morning show_time
	@echo "Nice to see you"
say_hello_morning: 
	@echo "Good morning World"
show_time:
	@echo It is %time%
```

Please note that you can just test the file by seeing what make will try to run and it's called a `dry run`
  make -n

Together, the target, prerequisites (or dependencies), and comaands (or actions) form a rule.

If you run it, you will see:
echo "Good morning World"
echo It is %time%
echo "Nice to see you"


# Adding a comment:
If you need to comment a file you have 2 options
1. Just add # right at the begining of the line and it won't execute that line
```
say_hello: say_hello_morning tell_time
#	@echo "Nice to see you"
say_hello_morning: 
	@echo "Good morning World"
tell_time:
	@echo It is %time%
```

2. Or, if you want to comment more code, a faster way would be `BOGUS` block
```
say_hello: say_hello_morning tell_time
define BOGUS
#	@echo "Nice to see you"
endef
say_hello_morning: 
	@echo "Good morning World"
tell_time:
	@echo It is %time%
```


# Running external scripts:
These prerequisites can be also files, like .bat or .sh files. See below:

Let's say we create a file `create_myfolder.bat`
and we add to it:
```
@mkdir myfolder
```

Modify the makefile to the following and run it
```
say_hello: say_hello_morning tell_time
	@echo "Nice to see you"
say_hello_morning: 
	@echo "Good morning World"
	create_myfolder.bat
tell_time:
	@echo It is %time%
```

This new change will do and print the following:
echo "Good morning World"
create the folder with create_myfolder.bat 
and it will tell time


We can add more stuff to that `.bat` file, such as adding files to it:
```
@mkdir myfolder

:: go to folder
@cd myfolder

:: creates 3 files named file-1.txt, file-3.txt, file-5.txt. From 1 , with a step of 2 until 6.
@for /L %%n in (1 2 6) do (type nul > file-%%n.txt)

:: leave this folder
@cd ..
```
* Please note this command is written to be used from command line. Inside a batch file percent signs need to be escaped (doubling them), replacing %a with %%a

You can also delete files in that directory (or a filename from that dir)

all files 
```
@del myfolder 
```
or entire directory
```
::where /s help with complaining that the directory is not empty
@rmdir myfolder /s
```

Thanks!