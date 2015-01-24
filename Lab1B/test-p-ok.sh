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

cat >test.sh <<'EOF'
true

echo echo1
echo echo4 | cat

echo writing to file > f1.txt
cat f1.txt # filename as argument
echo writing to file again > f1.txt
cat < f1.txt # file from stdin

echo echo5 | cat ; echo echo6; echo echo7

if true
then
echo count
else
echo no count
fi

if true
then
echo ball
else
echo no ball 
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

g++ -c foo.c
EOF

cat >test.exp <<'EOF'
echo1
echo4
writing to file
writing to file again
echo5
echo6
echo7
count
hello
a
cat: file: No such file or directory
b
g++: foo.c: No such file or directory
g++: no input files
EOF

../profsh test.sh >test.out 2>test.err || exit

diff -u test.exp test.out || exit
test ! -s test.err || {
  cat test.err
  exit 1
}

) || exit

rm -fr "$tmp"
