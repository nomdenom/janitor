#!/usr/bin/env ruby
MARKER = "//HACK"
ENDMARKER = "//ENDHACK"

START = <<-EOS
#{MARKER}s
typedef int8_t __int8;
typedef int16_t __int16;
typedef int32_t __int32;
typedef int64_t __int64;

typedef uint8_t _BYTE, BYTE, BOOL;
typedef uint16_t _WORD, WORD;
typedef uint32_t _DWORD, DWORD;
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

def transform(contents, state = nil)
    if contents.start_with?(MARKER)
        if state != true
            contents \
                .sub(/\A#{MARKER}.*?#{ENDMARKER}\n/m, "")
                .gsub(/^(#{WS})if \(!\((.*?)\) \/\*OOO.*$/, "\\1}\n\\1while (\\2);")
                .gsub(/^(#{WS})while.*\/\*OOO.*$/, "\\1do")
                .gsub(/\/\*JOIN\*\/(,)?\s*/, "\\1 ")
                .gsub("/*SPACE*/", " ")
                .gsub(/^(#{WS})(for .*) {/, "\\1\\2\n\\1{")
                .gsub(/\/\*SKIP:(.*?)\*\//, "\\1")
                .gsub(/\buint(\d+)_t\b/, "unsigned __int\\1")
                .gsub(/\bint(\d+)_t\b/, "signed __int\\1")
        else
            contents
        end
    elsif state != false
        START + \
            contents \
            .gsub(/^(#{WS})do#{WS}$/, "\\1while(1) /*OOO*/")
            .gsub(/\n#{WS}}(\n#{WS})while \((.*?)\);/, "\\1if (!(\\2) /*OOO*/ ) break; }")
            .gsub(/struct \w+_init.*?_init;/m, "/*YYY\\0YYY*/")
            .gsub(/\b__fastcall|__cdecl|__stdcall\b/, "/*SKIP:\\0*/")
            .gsub(/\bunsigned __int(\d+)\b/, "uint\\1_t")
            .gsub(/\bsigned __int(\d+)\b/, "int\\1_t")
    else
        contents
    end
end

def transform_inplace(f, state)
    s = File.read(f).to_lf
    s = transform(s, state)
    File.write(f, s.to_crlf)
end

if __FILE__ == $0
    contents = ARGF.read.to_lf
    print transform(contents).to_crlf
end