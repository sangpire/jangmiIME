
MOCHA = ./node_modules/mocha/bin/mocha
MOCHA_OPTS = --compilers coffee:coffee-script

input:
	coffee input.coffee

test:
	@${MOCHA} ${MOCHA_OPTS} 

test-watch:
	@${MOCHA} ${MOCHA_OPTS} -w

.PHONY: input test test-watch
