#Test big
echo ASDFSFADFSAFJFFKFJKFDKFAJFDKFJDKFJDFKSDJKFDSKFDJFKDFJKDSJFKDJFKDSFJDSKFJADSFKDJFKDJFKDFJKDJFKADSFJKDJDSFKDSAJKDJFKDAJFKDSJFKSDJFSDKFJSDKFJDSKFJDSKFJDSKFJDFJKFDSKFJDSK >txt.txt

cat < txt.txt | cat

rm txt.txt

#Check on SEASNET
sort /usr/share/dict/words > /dev/null

#in a subshell
(sort /usr/share/dict/words > /dev/null)

#Check if commands
echo hello > in.txt
if cat; then cat; fi < in.txt

rm in.txt

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

rm file

#subshells
(echo a)
(echo a | cat)
(echo bob) > file3

rm file2
rm file3

#exec test
(exec echo b)
exec echo bc
