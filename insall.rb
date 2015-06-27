#!/usr/bin/env ruby
require "highline/import"
require "FileUtils"

home = ENV.fetch("HOME")
backup_folder = "#{FileUtils.pwd}/files"
dot_files = %x[ find #{backup_folder} -type f -maxdepth 1 ].split("\n")
files = dot_files.map { |f| "#{home}/.#{File.basename(f).gsub(/^\./,"")}" }

puts "Found #{dot_files.count} backed up dot files."
puts "Will overwrite the following files:"
files.each { |f| puts "  #{f}"}
puts ""
exit unless HighLine.agree("Continue? ")

# copy
dot_files.each do |f|
  FileUtils.cp(f, "#{home}/.#{File.basename(f).gsub(/^\./,"")}", :noop => true, :verbose => true)
end

puts "\ndone.\n"