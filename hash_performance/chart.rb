#!/usr/bin/env ruby


require 'rubygems'
require 'googlecharts'

langs 	= []
values 	= {}
data 	= []
colors 	= []
max_y 	= 0

x = (1..20).map {|e| 2**e }

files = Dir.glob("values.*")

files.each do |file|
	f = File.open(file)
	langs << file.sub('values.','')
	colors << "%06x" % (rand * 0xffffff)
	tmp = []
	f.readlines.each do |l|
		val = l.chomp.to_f
		tmp << val
		max_y =  val if val > max_y 
	end
	data << tmp
end

puts Gchart.line(
	    :size 		=> '500x300', 
	    :title		=> "Hash Reads Performance",
	    :bar_colors 	=> colors,
	    :bg			=> 'efefef',
	    :legend		=> langs,
	    :axis_with_labels	=> 'x,y',
	    :axis_labels	=> [x],
	    :axis_range		=> [nil,[0,1,max_y]],
	    :data 		=> data
)
