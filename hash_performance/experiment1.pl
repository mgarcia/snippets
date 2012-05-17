#!/usr/bin/env perl

use strict;
use Benchmark qw(:hireswallclock :all);
use Data::Dumper;


use constant ITERATIONS => 10000;
my @y;
foreach my $exponent (1..20){
	my $size = 2**$exponent;
	my %hash = {};
	my $target_index = 0;
	foreach my $n (1..$size){
		my $index = rand;
		$hash{$index} = rand;
		$target_index = $index if $n == $size/2;
	}



	clearallcache();
	my $t = timeit(ITERATIONS, sub{my $val = $hash{$target_index}; });
	#timethis(ITERATIONS, sub{my $val = $hash{$target_index}});

	printf "retrieving an element from a hash with $size elements %d times tooks %.2f ms\n", ITERATIONS, 1000 * timestr($t);

	push @y, sprintf("%.2f", 1000 * timestr($t));
}

my $file = sprintf("values.perl-%vd", $^V);
open(my $fh, ">", $file) or die "$!";
print $fh "$_\n" for @y;



