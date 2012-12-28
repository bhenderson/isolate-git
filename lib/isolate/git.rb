require 'isolate'

module Isolate
  module Git

    def git?
      @options.key? :git
    end

    def git_build
    end

    def git_clone
      # silence output?
      # @sandbox.log s
      system "git clone #{@options[:git]}"
    end

    def git_setup
      Dir.chdir git_source_path do
        # clone
        git_clone
        # build
        git_build
        # set @file in entry
        @file = git_pkg_path
      end
    end

    def git_source_path
      File.join *[
        @sandbox.path,
        ('..' if @sandbox.multiruby?),
        'src'
      ].compact
    end

  end

  class Entry
    include Git
  end

  Isolate::Event.watch Isolate::Entry, :installing do |entry|
    entry.git_setup if entry.git?
  end
end
