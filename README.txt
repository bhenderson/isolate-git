= isolate-git

* https://github.com/bhenderson/isolate-git

== DESCRIPTION:

Git plugin for Isolate.

== FEATURES/PROBLEMS:

I now know why jbarnette did not add this functionality. There is no standard
way to build a gem from source. If you want to use this you have to make sure
you do a couple of things:

* make sure the git source url is cloneable from the machine that isolates.
* make sure that you have all the dependencies to build the gem (rake, hoe,
  etc.) in your isolate environment.

== SYNOPSIS:

Require the file (usually in the Isolate file)

  require 'isolate/git'

Add git source urls to gems in your Isolate file.

  gem "your-cool-code", :git => "git://example.com/your/cool/code.git"

Isolate::Git adds an Isolate::Events hook for Entry/installing. For every
entry it checks if the :git option was added. Then does a git clone in a
subdirectory of your isolate path. Then it builds the gem if a gemspec file
exists or runs `rake package` if there is a Rakefile (assuming the use of
something like Hoe). If any of this fails it will try to get out of the way
and just let Isolate continue to try and install the gem.

My rational for this is that you should just be installing packaged gems. This
can be useful for code which has not been released (ever). Please let me know
(by way of pull requests) if there are other ways to build gems or bugs or
whatever.

== REQUIREMENTS:

* isolate

== INSTALL:

* gem install isolate-git

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2012 bhenderson

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
