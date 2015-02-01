#check fail
jibjab

#Test simple commands
echo echo1

#Test long commands
sort /usr/share/dict/words > /dev/null
(sort /usr/share/dict/words > /dev/null)

#Test if statement
if gobble
then
echo count
else
echo no count
fi

#Test if statement
if false
then
echo count
else
echo no count
fi

#Test if statement with input-output
if :
then
echo ball > test.txt
else
echo no ball > test.txt
fi

#test interesting while
while
until :; do echo yoo hoo!; done
false
do echo b
done

#More if statement tests
echo hello > in.txt
if cat; then cat; fi < in.txt

#Check while loops
touch file
touch file2
echo a > file2
cp file2 file
while cat file; do rm file; done

#Check above worked
echo notfailedabove

#Check until loops
touch file
touch file2
echo b > file2
cp file2 file
until cat file; do rm file; done

#Check subshells
(echo a)
(echo a | cat)
(echo bob) > file3
(
echo a | cat
exec echo bob
)

#Clean all temp files
rm test.txt
rm file2
rm f1.txt
rm in.txt
rm file3
rm file

#Test exec command
exec cat dog

#Test what happens after exec
echo exec_ran

#Check subshells
(echo a)
(echo a | cat)
(echo bob) > file3
(
echo a | cat
exec echo bob
)
