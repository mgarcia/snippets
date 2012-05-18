fs 	= require 'fs'
timeit	= require 'timeit'
b 	= require 'b'



iterations = 10000


# Print Bench reports
class Reporter
	constructor: ()->
		@data = []
	report: (name, result, iterations)->
		console.log "retrieving an element from a hash with #{size} elements #{iterations} times tooks #{result} ms"
		@data.push(result)


reporter = new Reporter

for exponent in [1..20]
	size = Math.pow(2,exponent)
	hash = {}
	target_index = 0
	for n in [1..size]
		index = Math.random()
		hash[index] = Math.random()
		target_index = index if n == size / 2

	b('Read Test').reporter(reporter).run(iterations, ()->
		val = hash[target_index]
	)

stream = fs.createWriteStream("values.node-#{process.versions.node}")
stream.once('open', (fd)->
	for val in reporter.data
		stream.write "#{val}\n"
)


