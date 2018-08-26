#!/usr/bin/env ruby
START = <<-EOS
//HACK
typedef int32_t __int32;
typedef int64_t __int64;
EOS

WS = /[ \t]*/

class String
    def to_lf
        encode(encoding, universal_newline: true)
    end

    def to_crlf
        encode(encoding, crlf_newline: true)
    end
end

def print_lf(x)
    print x.to_crlf
end

contents = ARGF.read.to_lf

if contents.start_with?(START)
    contents = contents[START.length..-1]
    print_lf contents \
        .gsub(/^(#{WS})if \(!\((.*?)\) \/\*OOO.*$/, "\\1}\n\\1while (\\2);")
        .gsub(/^(#{WS})while.*\/\*OOO.*$/, "\\1do")
        .gsub(/\/\*JOIN\*\/(,)?\s*/, "\\1 ")
        .gsub(/^(#{WS})(for .*) {/, "\\1\\2\n\\1{")
else
    print_lf START + \
        contents \
        .gsub(/^(#{WS})do#{WS}$/, "\\1while(1) /*OOO*/")
        .gsub(/\n#{WS}}(\n#{WS})while \((.*?)\);/, "\\1if (!(\\2) /*OOO*/ ) break; }")
        .gsub(/struct \w+_init.*?_init;/m, "/*YYY\\0YYY*/")
end