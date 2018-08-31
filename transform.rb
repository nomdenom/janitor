#!/usr/bin/env ruby
MARKER = "//HACK"
ENDMARKER = "//ENDHACK"

START = <<-EOS
#{MARKER}
typedef int32_t __int32;
typedef int64_t __int64;
typedef uint86_t _BYTE;
typedef uint16_t _WORD;
typedef uint32_t _DWORD;
#{ENDMARKER}
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

if contents.start_with?(MARKER)
    print_lf contents \
        .sub(/\A#{MARKER}.*?#{ENDMARKER}\n/m, "")
        .gsub(/^(#{WS})if \(!\((.*?)\) \/\*OOO.*$/, "\\1}\n\\1while (\\2);")
        .gsub(/^(#{WS})while.*\/\*OOO.*$/, "\\1do")
        .gsub(/\/\*JOIN\*\/(,)?\s*/, "\\1 ")
        .gsub("/*SPACE*/", " ")
        .gsub(/^(#{WS})(for .*) {/, "\\1\\2\n\\1{")
        .gsub(/\/\*SKIP:(.*?)\*\//, "\\1")
else
    print_lf START + \
        contents \
        .gsub(/^(#{WS})do#{WS}$/, "\\1while(1) /*OOO*/")
        .gsub(/\n#{WS}}(\n#{WS})while \((.*?)\);/, "\\1if (!(\\2) /*OOO*/ ) break; }")
        .gsub(/struct \w+_init.*?_init;/m, "/*YYY\\0YYY*/")
        .gsub(/\b__fastcall|__cdecl|__stdcall\b/, "/*SKIP:\\0*/")
end
