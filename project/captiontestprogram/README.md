The corresponding code on f22 is in ~jgordon/wwwdocs/api, but I want to
move it to /u/www/research/epilog/api after that gets its permissions
reset.


This test.py script does the following:
    It picks out all the xml files in current working directory,
    for each one of them, it passes the xml file to a server that 
    runs EPILOG.

    Once the result is back, it is stored in the 'u' varialbe and
    then it is written in a file in the "result" subdirectory.


To use this test program, we need to have input files with sufix 'xml'
at the postion where the 'test.py' is. 

Then type in 'make' in the terminal.

The result are stored in the subdirectory named 'result', with 'out'
cancatinated with the original input xml filename.

For example, if we have inputX.xml at directory ~/foo_dir and the 
test.py file also locats at ~/foo_dir. The result will be put at
~/foo_dir/result/final_result.xml