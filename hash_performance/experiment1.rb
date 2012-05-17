#!/usr/bin/env ruby

require 'benchmark'

ITERATIONS = 10000

x=[]
y=[]
(1..20).each do |exponent|

  size = 2**exponent
  hash = {}
  target_index = 0
  (1..size).each do |n|
    index = rand
    hash[index] = rand
    target_index = index if n == size/2
  end
  
  GC.start

  time = Benchmark.realtime do
      ITERATIONS.times do |n|
        val = hash[target_index]
      end
  end
  #puts "#{size} Time elapsed #{time*1000} milliseconds"
  puts "retrieving an element from a hash with #{size} elements #{ITERATIONS} times tooks %.2f ms\n" % (time*1000)
  x << size
  y << "%.2f" % (time*1000)

  #Benchmark.bm do |bench|
  #  bench.report("retrieving an element from a hash with #{size} elements #{ITERATIONS} times\n") do
  #    ITERATIONS.times do |n|
  #      val = hash[target_index]
  #    end
  #  end
  #end

end

outfile = File.new("values.ruby-#{RUBY_VERSION.gsub('"','')}", 'w')
y.map{|y| outfile.puts(y)} 
outfile.close
