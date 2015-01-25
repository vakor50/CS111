true

: : :

echo echo1
echo echo4 | cat

echo writing to file > f1.txt
cat f1.txt # filename as argument
echo writing to file again > f1.txt
cat < f1.txt # file from stdin

echo echo5 | cat ; echo echo6; echo echo7

if :
then
echo count
else
echo no count
fi

if :
then
echo ball > test.txt
else
echo no ball > test.txt
fi

echo hello > in.txt
if cat; then cat; fi < in.txt

touch file
touch file2
echo a > file2
cp file2 file
while cat file; do rm file; done

touch file
touch file2
echo b > file2
cp file2 file
until cat file; do rm file; done

rm test.txt
rm file2
rm f1.txt
rm in.txt
