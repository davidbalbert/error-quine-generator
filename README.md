error-quine-generator.rb
========================

A quine is a program that prints itself. They are generally hard to write. An error quine is a cheater's quine. The input file contains an error message that when fed into an interpreter outputs the same error message.

This program generates error quines by starting with some seed text in the form `random_string(random_string)` and running that text through the specified interpreter until the output is the same as the input.

##Usage

error-quine-generator.rb requires Ruby 1.9.

    $ ruby error-quine-generator.rb 
    usage: error-quine-generator.rb [-v] <language> [<max iterations> <seed text>]

    <language>        The name of the interpreter to use
    <seed text>       The initial text to run through <language>. Optional
    <max iterations>  A maximum number of times to run <language>. Optional
    -v                Verbose mode. Print seed text and intermediate output

The result is saved to `/tmp/quine.extension`. E.g. `ruby error-quine-generator.rb ruby` would write its result to `/tmp/quine.rb`. The quine will also be printed to the screen.

##Assumptions

- The specified interpreter is invoked with the form: `interpreter /path/to/file`. E.g. `ruby /tmp/quine.rb`
- `<max iterations>` is an integer. If the second parameter (excluding `-v`) is not an integer, it will be treated as the seed text.

##Languages

Filetype extensions are hardcoded into `error-quine-generator.rb`. It includes support for Ruby, Python, Awk, Perl, PHP, Node and CoffeeScript. Other interpreters will work, but their output will be in `/tmp/quine` with no extension.

I have found the script to work with Ruby, Python, Awk, PHP, node, and CoffeeScript. If you know other languages that work, please let me know.

Perl doesn't work because it tries to continue parsing after finding an error, resulting in ever growing output.

PHP really feels like cheating because anything not inside `<?php ... ?>` just evaluates to itself. This makes it techincally not an error quine, but it's still a quine that can be generated by this script.

##Credits

This project was inspired by [Harold Cooper](https://github.com/hrldcpr).

##Copyright

`error-quine-generator.rb` was written by David Albert and is released to the Public Domain. See https://creativecommons.org/publicdomain/zero/1.0/ for more info.
