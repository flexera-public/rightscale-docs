#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'

def processdir(dirname)
  # check if output directory exists and delete...
  if Dir.exists? 'word-output'
    FileUtils.rm_rf 'word-output'
  end
  puts "Creating output directory..."
  Dir.mkdir('word-output')
  puts "Processing files in source directory..."
  Dir.foreach(dirname) do |item|
    myfilename = "#{item}"
    if myfilename.include? ".md"
      puts myfilename
      system("pandoc " +  "./" + dirname + "/" + myfilename + " -o" + " " + "./word-output/" + myfilename + ".docx")
    end
  end
end

processdir(ARGV[0]);
