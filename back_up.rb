#!/usr/bin/env ruby
require "highline/import"
require "FileUtils"

home = ENV.fetch("HOME")
backup_folder = "#{FileUtils.pwd}/files"

dot_files = %x[ find #{home} -type f -maxdepth 1 -name '.*' ].split("\n")
excluded_files = %w( 
  DS_Store pgpass APKey.plist bash_history guard_history irb-history 
  mysql_history pry_history psql_history rediscli_history Rhistory 
  sh_history meteorsession netrc pearrc s3cfg 
  viminfo Xauthority).map { |e| e = "#{home}/.#{e}" }

files = dot_files - excluded_files

# print to user
puts "Found #{dot_files.count} dot files, excluding #{excluded_files.count} files."
puts "Will backup the following files:"
files.each { |f| puts "  #{f}"}
puts ""
exit unless HighLine.agree("Continue? ")

# copy
files.each do |f|
  basename = File.basename(f).gsub(/^\./,"")
  FileUtils.cp(f, "#{backup_folder}/#{basename}")
end

puts "\ndone.\n"
puts "Don't forget to commit changes.\n"