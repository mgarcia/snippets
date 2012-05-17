#!/usr/bin/env python

import sys
import random
import timeit
import __builtin__




ITERATIONS=10000
hash = {} 
target_index = 0
y = []

for exponent in range(1,20): 
	size = 2**exponent
	hash = {} 
	target_index = 'qwe'
	for n in range(1,size):
		index = random.random()
		hash[index] = random.random()
		if n == size/2:
			target_index = index
	__builtin__.__dict__.update(locals())
	s = "val = hash[target_index]"
	t = timeit.Timer(s)
	print "retrieving an element from a hash with %d elements %d times tooks %.2f msec" % (size, ITERATIONS, 1000 * t.timeit(number=ITERATIONS))
	y.append("%.2f" % (1000 * t.timeit(number=ITERATIONS)) )
	

f = open("values.python-%s" %  sys.version[:5], 'w')
for i in y:
	f.write("%s\n" % i)
