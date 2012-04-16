#!/usr/bin/perl -w

use strict;

use Memoize;

memoize('num_of_ones');


my $num =  $ARGV[0] || 1;

print "numberOfones($num)= ",num_of_ones($num),"\n";

#
sub num_of_ones{
        my $n = shift;

        return 0 if $n < 1;
        return 1 if $n <= 9;

        my @a= split('',$n);

        my $len = length($n);
        my $sum = 0;
        my $delta = 0;

	if($a[0] > 1){
		$delta += 10**($len-1);
	}else{
		$delta += substr($n,1) + 1;
	}

        $sum += $delta + $a[0]*num_of_ones(9x($len-1))+ num_of_ones(substr($n,1));
        return $sum;
}
