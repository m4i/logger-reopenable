logger-reopenable
=================

logger-reopenable provides `Logger#reopen`.

[![Build Status](https://travis-ci.org/m4i/logger-reopenable.png?branch=master)](https://travis-ci.org/m4i/logger-reopenable)
[![Coverage Status](https://coveralls.io/repos/m4i/logger-reopenable/badge.png?branch=master)](https://coveralls.io/r/m4i/logger-reopenable?branch=master)
[![Code Climate](https://codeclimate.com/github/m4i/logger-reopenable.png)](https://codeclimate.com/github/m4i/logger-reopenable)


Installation
------------

Add this line to your application's Gemfile:

    gem 'logger-reopenable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logger-reopenable

Usage
-----

```ruby
require 'logger-reopenable'

logger = Logger.new('foo.log')
logger.info 'bar'

# Log Rotation
File.rename('foo.log', 'foo.log.1')

logger.info 'baz'
logger.reopen
logger.info 'qux'
```

foo.log
```plain
# Logfile created on 2013-09-25 17:52:59 +0900 by logger.rb/36483
I, [2013-09-25T17:52:59.020089 #46086]  INFO -- : qux
```

foo.log.1
```plain
# Logfile created on 2013-09-25 17:52:59 +0900 by logger.rb/36483
I, [2013-09-25T17:52:59.013570 #46086]  INFO -- : bar
I, [2013-09-25T17:52:59.017638 #46086]  INFO -- : baz
```


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
