require "bundler/gem_tasks"

task :console do
  require 'irb'
  require 'irb/completion'
  require 'nails' # You know what to do.

  def reload!
    # Change 'my_gem' here too:
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/nails\// }
    files.each { |file| 
      puts file
      load file }
  end

  ARGV.clear
  IRB.start
end
