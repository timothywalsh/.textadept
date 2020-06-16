-- Julia LPed lexer for Textadept.
-- Copyleft 2020 Timothy Walsh

local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local lex = lexer.new('julia')

-- Whitespace.
lex:add_rule('whitespace', token(lexer.WHITESPACE, lexer.space^1))

-- Keywords.
lex:add_rule('keyword', token(lexer.KEYWORD, word_match[[
  baremodule begin break catch const continue do 
  else elseif end export false finally for function 
  global if import let local macro module quote 
  return struct true try using while
  'abstract type' 'mutable struct' 'primitive type'
  where in isa '...' 
]]))

-- Functions.
lex:add_rule('function', token(lexer.FUNCTION, word_match[[
  Array String Bool Number Int Integer Real Complex
	FloatingPoint Float64 Float32 Int8 Int16 Int32 Int64
	Rational AbstractArray Unsigned Signed Uint Uint8 Uint16
	Uint32 Uint64 Vector AbstractVector Matrix AbstractMatrix
	Type IO Any ASCIIString Union Dict Function SubArray
	Range Range1 Symbol Expr
  string cell collect filter merge divrem hex dec oct base
	int round cmp float linspace fill start done tuple
	minimum maximum count index append push pop shift
	unshift insert splice reverse sort zip length delete
	copy haskey keys values get getkey Set isa issubset
	intersect setdiff symdiff complement print printf println
	sprintf utf8 char search rsearch
	replace lowercase uppercase ucfirst lcfirst union
	split rsplit chop chomp lpad rpad lstrip rstrip
	strip isalnum isalpha isascii isblank iscntrl isdigit
	isgraph islower isprint ispunct isspace isupper isxdigit
	match captures offset offsets matchall eachmatch hcat
	vcat hvcat reshape deepcopy similar reinterpret map
	reduce mapreduce DataArray DataFrame removeNA replaceNA
	colnames head tail describe join groupby by stack
	readtable readcsv readdlm writetable writecsv writedlm
	require reload include evalfile cd open write close
	position seek seekstart skip isopen eof
	isreadonly ltoh htol serialize deserialize download
	isequal getindex setindex eachline beginswith endswith
	parsefloat parseint seekend findnz DivideError addprocs
	scale issubnormal readdir mapslices
  abs 
]]))

-- Constants.
lex:add_rule('constant', token(lexer.CONSTANT, word_match[[
  run spawn success process_running process_exited kill
	readsfrom writesto readsandwrite detach setenv ENV getpid
	clipboard strftime time gethostname getipaddr pwd
	mkdir mkpath rmdir ignorestatus
]]))

-- Prompt.
--lex:add_rule('prompt', token(lexer.PROMPT, word_match[[
--julia>
--]]))

-- Symbols. This is not working yet... I must be missing something
lex:add_rule('symbol', token(lexer.SYMBOL, ':' * lexer.word))
lex:add_style('symbol', lexer.STYLE_KEYWORD)

-- Identifiers. i.e. words
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Strings.
lex:add_rule('string', token(lexer.STRING, lexer.delimited_range("'") +
                                           lexer.delimited_range('"')))

-- Comments.
lex:add_rule('comment', token(lexer.COMMENT, '#' * lexer.nonnewline^0))

-- Numbers.
lex:add_rule('number', token(lexer.NUMBER, lexer.float + lexer.integer))

-- Decorators.
lex:add_rule('decorator', token('decorator', '@' * lexer.nonnewline^0))
lex:add_style('decorator', lexer.STYLE_PREPROCESSOR)

-- Operators.
lex:add_rule('operator', token(lexer.OPERATOR, S('+-*/%^=<>.{}[]()')))
--TODO: make the operators a different colour

-- Fold points.
lex:add_fold_point(lexer.KEYWORD, 'function', 'end')
lex:add_fold_point(lexer.OPERATOR, '{', '}')
lex:add_fold_point(lexer.COMMENT, '#', lexer.fold_line_comments('#'))





return lex
