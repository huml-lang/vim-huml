" Vim syntax highlighter
" Language: HUML
" Homepage: https://github.com/huml-lang/vim-huml
" Latest Revision: 2025-05-30
" Version: 0.1.0

if exists("b:current_syntax")
  finish
endif

syntax case match

" Version declaration
syntax match humlVersion /^%HUML\s\+\d\+\.\d\+\s*\(#.*\)\?$/

" Comments
syntax match humlComment /#.*$/ containedin=ALL

" Keys - must come before separators to avoid conflicts
syntax match humlVectorKey /^\s*\zs\("\?\)\h[-\w.]*\1\ze\s*::/ nextgroup=humlVectorSeparator
syntax match humlScalarKey /^\s*\zs\("\?\)\h[-\w.]*\1\ze\s*:/ nextgroup=humlScalarSeparator
syntax match humlInlineKey /\("\?\)\h[-\w.]*\1\ze\s*:/ contained

" Separators - make them distinct
syntax match humlVectorSeparator /::/ contained nextgroup=humlVectorValue
syntax match humlScalarSeparator /:/ contained nextgroup=humlScalarValue
syntax match humlInlineSeparator /:/ contained

" List items - handle both simple and inline dictionary list items
syntax match humlListMarker /^\s*-\ze\s\+::/ nextgroup=humlListInlineDict
syntax match humlListMarker /^\s*-\ze\s\+[^:]/ nextgroup=humlListValue
syntax match humlListInlineDict /\s*::/ contained nextgroup=humlListInlineDictValue

" Values and constants
syntax region humlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=humlEscape
syntax region humlTripleString start=/"""/ end=/"""/ 
syntax region humlBacktick start=/```/ end=/```/ 
syntax match humlEscape /\\["\\\/bfnrt]/ contained
syntax match humlNumber /\v<([-+]\d[\d_]*(\.\d+)?([eE][-+]?\d+)?|0x[\da-fA-F_]+|0o[0-7_]+|0b[01_]+|nan|[-+]?inf)>/
syntax keyword humlBoolean true false
syntax keyword humlNull null
syntax match humlEmpty /\[\]\|{}/ 

" Delimiters
syntax match humlComma /,/ contained

" Value regions - these define what can appear after separators
syntax region humlVectorValue start=/\s*/ end=/$/ end=/^\s*\ze\S/me=s-1 contained contains=humlString,humlTripleString,humlBacktick,humlNumber,humlBoolean,humlNull,humlEmpty,humlComma,humlInlineKey,humlInlineSeparator,humlComment
syntax region humlScalarValue start=/\s*/ end=/$/ contained contains=humlString,humlTripleString,humlBacktick,humlNumber,humlBoolean,humlNull,humlEmpty,humlComment
syntax region humlListValue start=/\s*/ end=/$/ end=/^\s*\ze\S/me=s-1 contained contains=humlString,humlTripleString,humlBacktick,humlNumber,humlBoolean,humlNull,humlEmpty,humlComment
syntax region humlListInlineDictValue start=/\s*/ end=/$/ end=/^\s*\ze\S/me=s-1 contained contains=humlString,humlTripleString,humlBacktick,humlNumber,humlBoolean,humlNull,humlEmpty,humlComma,humlInlineKey,humlInlineSeparator,humlComment

" Highlight links
highlight link humlVersion         PreProc
highlight link humlComment         Comment
highlight link humlVectorKey       Identifier
highlight link humlScalarKey       Identifier
highlight link humlInlineKey       Identifier
highlight link humlVectorSeparator Operator
highlight link humlScalarSeparator Operator
highlight link humlInlineSeparator Operator
highlight link humlListMarker      Special
highlight link humlString          String
highlight link humlTripleString    String
highlight link humlBacktick        String
highlight link humlEscape          SpecialChar
highlight link humlNumber          Number
highlight link humlBoolean         Boolean
highlight link humlNull            Constant
highlight link humlEmpty           Constant
highlight link humlComma           Delimiter

let b:current_syntax = "huml"
