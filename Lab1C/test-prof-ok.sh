#! /bin/sh

# UCLA CS 111 Lab 1 - Test that valid syntax is processed correctly.

# Copyright 2012-2014 Paul Eggert.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

tmp=$0-$$.tmp
mkdir "$tmp" || exit

(
cd "$tmp" || exit

cat >test2.sh <<'EOF'
#Check simple word
true

#check fail
jibjab

#Check colons
: : :

#Test simple commands
echo echo1

#Test pipe
echo echo4 | cat

#Test simple commands with input-output
echo wrote to file > f1.txt
cat f1.txt
echo wrote to file again > f1.txt
cat < f1.txt

#Test pipe and sequence commands
echo echo5 | cat ; echo echo6; echo echo7

#Test if statement
if gobble
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
EOF

cat >test2.exp <<'EOF'
../profsh: Invalid simple command: No such file or directory
echo1
echo4
wrote to file
wrote to file again
echo5
echo6
echo7
../profsh: Invalid simple command: No such file or directory
no count
hello
a
cat: file: No such file or directory
notfailedabove
b
a
a
a
bob
cat: dog: No such file or directory
EOF

../profsh -p f.shp test2.sh >test2.out 2>&1

diff -u test2.exp test2.out || exit
#test ! -s test.err || {
#  cat test.err
#  exit 1
#}

) || exit

rm -fr "$tmp"
