
MOCHA = ./node_modules/mocha/bin/mocha
MOCHA_OPTS = --bail --compilers coffee:coffee-script/register --reporter spec

input:
	coffee input.coffee

test:
	@${MOCHA} ${MOCHA_OPTS}

test-watch:
	@${MOCHA} ${MOCHA_OPTS} --watch

.PHONY: input test test-watch
