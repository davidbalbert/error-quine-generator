#!/usr/bin/env ruby

require 'open3'

EXTENSIONS = {
  "ruby" => ".rb",
  "python" => ".py",
  "awk" => ".awk",
  "perl" => ".pl",
  "php" => ".php",
  "node" => ".js"
}

def debug_puts(*args)
  errputs(*args) if $VERBOSE
end

def errputs(*args)
  STDERR.puts(*args)
end

def generate_quine(language, input)
  output = ""

  File.open("/tmp/quine#{EXTENSIONS[language]}", "w") do |f|
    f.puts(input)
    f.close

    output, _ = Open3.capture2e("#{language} #{f.path}")
  end

  output
end

def rand_string(length)
  rand(36**length).to_s(36)
end

def main(argv)
  if argv.include? "-v"
    $VERBOSE = true
    argv.delete("-v")
  else
    $VERBOSE = false
  end

  if argv.empty?
    errputs "usage: #{File.basename(__FILE__)} [-v] <language> [<max iterations> <seed text>]"
    errputs
    errputs "<language>\t\tThe name of the interpreter to use"
    errputs "<seed text>\t\tThe initial text to run through <language>. Optional"
    errputs "<max iterations>\tA maximum number of times to run <language>. Optional"
    errputs "-v\t\t\tVerbose mode. Print seed text and intermediate output"
    exit
  end

  max_iterations = nil
  if argv[1] and argv[1].to_i.to_s == argv[1]
    max_iterations = argv[1].to_i
    argv.delete_at(1)
  end

  # random text in format: bla(bla)
  input = argv[1] || "#{rand_string(7)}(#{rand_string(5)})"
  debug_puts "seed text: #{input}"

  output = ""

  count = 0

  loop do
    unless input == output
      debug_puts
      debug_puts input
    end

    output = generate_quine(argv[0], input)
    break if input == output

    if max_iterations
      count += 1
      break if count == max_iterations
    end

    input = output
  end

  if input == output and output != ""
    debug_puts
    puts output
  else
    errputs "Couldn't find a quine in #{max_iterations} iterations"
  end
end

if __FILE__ == $0
  main(ARGV)
end
