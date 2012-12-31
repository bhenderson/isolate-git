require 'isolate'
require 'fileutils'

module Isolate
  class Git

    VERSION = '0.1.0'

    def self.setup entry
      new(entry).setup
    end

    def initialize entry
      @entry = entry
    end

    def build
      gemspec_path = Dir['**/*.gemspec'].first.to_s

      # does the repo contain a gemspec? Just build it.
      if File.size? gemspec_path
        sh 'gem', 'build', gemspec_path
      # try running rake package. Projects that use Hoe for example don't come
      # with a gemspec, but one can be built. One may have to add build
      # dependencies to the Isolate file. ie. rake, hoe.
      elsif File.size? 'Rakefile'
        sh 'rake', 'package'
      else
        # don't know what to do
      end

      built_path = Dir['**/*.gem'].first.to_s

      if File.size? built_path
        built_path
      else
        log "unable to build or find #{@entry.name} gem"
        false
      end
    end

    def clone
      src = @entry.options[:git]
      name = @entry.name

      if sh 'git','clone', src, name
        name
      else
        log "unable to clone #{src}"
        false
      end
    end

    def git?
      @entry.options.key? :git
    end

    # For each entry, if options[:git] exists try to clone the repo and build
    # the gem. If either fails, warn and let Isolate continue doing it's normal
    # thing.
    def setup
      return unless git?

      Dir.chdir source_path do

        path = clone

        Dir.chdir path do

          if name = build then
            file = File.expand_path name

            # private instance variable. When this is set Entry#install looks
            # for a local file instead of trying to download by name
            @entry.instance_variable_set :@file, file
          end

        end if path

      end
    end

    # Where to put the git repos.
    def source_path
      src = File.join *[
        sandbox.path,
        ('..' if sandbox.multiruby?),
        'src'
      ].compact

      FileUtils.mkdir_p src

      src
    end

    private

    def log s
      sandbox.log s
    end

    def sandbox
      # I don't like looking in private variables
      @sandbox ||= @entry.instance_variable_get(:@sandbox)
    end

    def sh *args
      IO.popen(args) do |io|
        log io.gets until io.eof?
      end
      $?.success?
    end

  end

  # setup installing hook so that each entry that has a :git option is setup
  # correctly for activiation.
  Events.watch Entry, :installing do |entry|
    Git.setup entry
  end
end
