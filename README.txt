= bing

* https://github.com/hekaldama/bing

== DESCRIPTION:

Bing api client library that exposes all of Bing's api features.

== FEATURES/PROBLEMS:

* Uses Net::HTTP::Persistent for connections to Bing.
* Shipped with a community Bing api key. Only used for testing.
  Use in production may fail.

== SYNOPSIS:

All methods for retrieval strive to just pass through params to Bing. This is
desired to have Bing be canonical on the API integration with limited mapping
client side. What this means is that when Bing says it accepts the param
"centerPoint", you can pass this straight through as :center_point. The values
are simply strings which means when Bing says you do "centerPoint=47.610,
-122.107", you will do :center_point => '47.610,-122.107'.

Some code examples:

# For locations
require 'bing/location'

Bing.config[:api_key] = 'my_key'

Bing::Location.find :query => 'Strawberry, CA'

# For routing
require 'bing/route'

Bing.config[:api_key] = 'my_key'

Bing::Route.find :waypoints => ['Shasta, CA', 'Chico, CA', 'Los Angeles, CA']

== REQUIREMENTS:

For development:
* rubygems >= 1.8.2
* isolate >= 3.1.1

== INSTALL:

[sudo] gem install bing

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests, and generate the
RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2011 Adam Avilla

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
