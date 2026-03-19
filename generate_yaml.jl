#!/usr/bin/env julia

using Dates
import REPL: REPLCompletions

const JULIA_COPYRIGHT = "Copyright (c) 2009-$(year(now())): Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and other contributors"

const JULIA_LICENSE = """MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE."""

function write_yaml(io::IO, description::String, entries::Dict{<:AbstractString,<:AbstractString})
    println(io, "\"version\": \"$(VERSION)\"")
    println(io, "\"description\": $(description)")
    println(io, "\"copyright\": \"$(JULIA_COPYRIGHT)\"")
    println(io, "\"license\": |-")
    for line in split(JULIA_LICENSE, '\n')
        println(io, "  $(line)")
    end
    println(io, "\"okuri_ari\": {}")
    println(io, "\"okuri_nasi\":")
    for key in sort!(collect(keys(entries)))
        println(io, "  \"$(key)\":")
        println(io, "    - $(entries[key])")
    end
end

function main()
    mkpath("yaml")

    latex_entries = Dict(
        lstrip(keyword, '\\') => unicode
        for (keyword, unicode) in REPLCompletions.latex_symbols
    )
    open("yaml/SKK-JISYO.julia-latex.yaml", "w") do io
        write_yaml(io, "Julia LaTeX unicode symbols for SKK abbrev mode", latex_entries)
    end

    emoji_entries = Dict(
        strip(lstrip(keyword, '\\'), ':') => unicode
        for (keyword, unicode) in REPLCompletions.emoji_symbols
    )
    open("yaml/SKK-JISYO.julia-emoji.yaml", "w") do io
        write_yaml(io, "Julia emoji unicode symbols for SKK abbrev mode", emoji_entries)
    end
end

main()
