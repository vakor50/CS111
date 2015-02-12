#! /usr/bin/perl -w

open(FOO, "osprd.c") || die "Did you delete osprd.c?";
$lines = 0;
$lines++ while defined($_ = <FOO>);
close FOO;

@tests = (
# Check the simple deadlock, locking the same ramdisk twice
    # 1
    [ 'echo foo | ./osprdaccess -w -l /dev/osprda /dev/osprda',
      "ioctl OSPRDIOCACQUIRE: Resource deadlock avoided" 
    ],

# Another simple deadlock
    # 2
    [ 'echo foo | ./osprdaccess -w -l /dev/osprda /dev/osprda & ' .
      './osprdaccess -r /dev/osprda',
      "ioctl OSPRDIOCACQUIRE: Resource deadlock avoided" 
    ],

# A more complex deadlock
    # 3
    [ 'echo deadlock| ./osprdaccess -w -l -d 0.1 /dev/osprda /dev/osprdb & ' .
      'echo deadlock| ./osprdaccess -w -l -d 0.1 /dev/osprdb /dev/osprda',
      "ioctl OSPRDIOCACQUIRE: Resource deadlock avoided" 
    ],


# multiple writes
    # 4
    [ '(echo test1 | ./osprdaccess -w) && ' .
      '(echo test2 | ./osprdaccess -w) && ' .
      '(./osprdaccess -r 16 | hexdump -C)',
      "00000000 74 65 73 74 32 0a 00 00 00 00 00 00 00 00 00 00 |test2...........| " .
      "00000010" 
    ],

    # 5
    [ '(echo test1 | ./osprdaccess -w) && ' .
      '(echo test2 | ./osprdaccess -w -o 5) && ' .
      '(./osprdaccess -r 16 | hexdump -C)',
      "00000000 74 65 73 74 31 74 65 73 74 32 0a 00 00 00 00 00 |test1test2......| " .
      "00000010" 
    ],
    );

my($ntest) = 0;

my($sh) = "bash";
my($tempfile) = "lab2test.txt";
my($ntestfailed) = 0;
my($ntestdone) = 0;
my($zerodiskcmd) = "./osprdaccess -w -z";
my(@disks) = ("/dev/osprda", "/dev/osprdb", "/dev/osprdc", "/dev/osprdd");

my(@testarr, $anytests);
foreach $arg (@ARGV) {
    if ($arg =~ /^\d+$/) {
	$anytests = 1;
	$testarr[$arg] = 1;
    }
}

foreach $test (@tests) {

    $ntest++;
    next if $anytests && !$testarr[$ntest];

    # clean up the disk for the next test
    foreach $disk (@disks) {
	`$sh <<< "$zerodiskcmd $disk"`
    }

    $ntestdone++;
    print STDOUT "Starting test $ntest\n";
    my($in, $want) = @$test;
    open(F, ">$tempfile") || die;
    print F $in, "\n";
    print STDERR $in, "\n";
    close(F);
    $result = `$sh < $tempfile 2>&1`;
    $result =~ s|\[\d+\]||g;
    $result =~ s|^\s+||g;
    $result =~ s|\s+| |g;
    $result =~ s|\s+$||;

    next if $result eq $want;
    next if $want eq 'Syntax error [NULL]' && $result eq '[NULL]';
    next if $result eq $want;
    print STDERR "Test $ntest FAILED!\n  input was \"$in\"\n  expected output like \"$want\"\n  got \"$result\"\n";
    $ntestfailed++;
}

unlink($tempfile);
my($ntestpassed) = $ntestdone - $ntestfailed;
print "$ntestpassed of $ntestdone tests passed\n";
exit(0);
