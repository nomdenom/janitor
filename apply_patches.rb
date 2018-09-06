#!/usr/bin/env ruby
require 'pathname'
require_relative 'transform'

OPTS = %w(--max-width=1000) # %w(--debug) # --verbose-parsing

PATCH_DIR = Pathname.new(__FILE__).realpath.dirname.relative_path_from(Pathname.pwd)

TRIVIAL_PATCHES = %w(
    assert.cocci
)

FAST_PATCHES = TRIVIAL_PATCHES + %w(
    for_increment_by.cocci
    for_increment.cocci
    increment_seq.cocci
    for_increment_fast.cocci
    for_increment.cocci
    for_decrement_fast.cocci
    for_decrement.cocci
)

SLOW_PATCHES = FAST_PATCHES + %w(
    arr_loop.cocci
)

def patch(pf, file, args = [])
    puts "##### #{file}: #{pf}" 
    cmd = %w(spatch.opt) + OPTS + args + %W(--in-place --sp-file #{PATCH_DIR}/#{pf} #{file})
    system *cmd
end

raise "Missing file argument" if ARGV.empty?
file = ARGV.pop

# Too complex to handle
return if file =~ /render\.cpp/

transform_inplace file, true

begin
    if ARGV.empty?
        patches = case
            when file =~ /scrollrt\.cpp/
                FAST_PATCHES
            when file =~ /render\.cpp/
                TRIVIAL_PATCHES
            else
                SLOW_PATCHES
            end
            
        patches.each do |pf|
            patch pf, file
        end
    else
        # Custom arguments
        system *(%w(spatch.opt) + %w(--in-place) + ARGV + [file])
    end
ensure
    transform_inplace file, false
end