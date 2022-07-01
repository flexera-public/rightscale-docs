#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'


old_ver = ARGV[0]
new_ver = ARGV[1]

remote_url = `git config --list | grep remote.origin.url`
unless remote_url.include?('rightscale/docs')
  raise "Run this from the docs repo"
end

unless old_ver && new_ver
  raise "Usage: new_rl_docs <old_version> <new_version>"
end

base_dir = `git rev-parse --show-toplevel`.chomp
ref_dir = File.join(base_dir,'source','rl10','reference')
old_dir = File.join(ref_dir, old_ver)
new_dir = File.join(ref_dir, new_ver)

raise "Cannot find #{old_dir}" unless File.exists?(old_dir)


system('git checkout master && git pull') or raise "Failed to checkout master && pull"
new_branch = "RightLink_#{new_ver}_release"
make_branch = `git branch`.include?(new_branch) ? '' : '-b'
system("git checkout #{make_branch} #{new_branch}") or raise "Failed to make/use git branch #{new_branch}"
system("mkdir -p #{new_dir}") or raise "Failed to make #{new_dir}"

Dir.glob(File.join(old_dir, '*.html.md')) do |f|
  new_f = f.sub(old_ver, new_ver)
  body = File.exists?(new_f) ? File.read(new_f) :  File.read(f)
  body.sub!(/version_number: .*$/, "version_number: #{new_ver}")

  File.write(new_f, body)
end

Dir.glob(File.join(ref_dir,"*","*")) do |f|
  body = File.read(f)
  _, yml, rest = body.split(/^---$/)
  if yml && rest
    rest.gsub!(old_ver, new_ver)
    new_f_name = File.basename(f.sub('.md',''))
    unless yml.include?("name: #{new_ver}")
      yml.sub!(/versions:/, "versions:\n  - name: #{new_ver}\n    link: /rl10/reference/#{new_ver}/#{new_f_name}")
    end
    File.write(f, "---#{yml}---#{rest}")
  else
    puts "WARN: no yml section for #{f}"
  end
end

