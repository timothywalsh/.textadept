-- Julia LPeg lexer.
-- Copyleft 2020 Timothy Walsh

local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local lex = lexer.new('julia')

-- Whitespace.
local ws = token(lexer.WHITESPACE, lexer.space^1)
lex:add_rule('whitespace', ws)

-- Keywords. From the manual
-- https://docs.julialang.org/en/v1/base/base/#Keywords-1
lex:add_rule('keyword', token(lexer.KEYWORD, word_match[[
  baremodule begin break catch const continue do 
  else elseif end export false finally for function 
  global if import let local macro module quote 
  return struct true try using while
  'abstract type' 'mutable struct' 'primitive type'
  where in isa '...' 
]]))

-- Core functions. julia> print(names(Core))
lex:add_rule('core', token(lexer.FUNCTION, word_match[[
  = == === =>
  AbstractArray AbstractChar AbstractFloat AbstractString 
  Any ArgumentError Array AssertionError Bool BoundsError 
  Char Core Cvoid DataType DenseArray DivideError DomainError 
  ErrorException Exception Expr Float16 Float32 Float64 Function 
  GlobalRef IO InexactError InitError Int Int128 Int16 Int32 
  Int64 Int8 Integer InterruptException LineNumberNode LoadError 
  Main Method MethodError Module NTuple NamedTuple Nothing Number 
  OutOfMemoryError OverflowError Ptr QuoteNode ReadOnlyMemoryError 
  Real Ref SegmentationFault Signed StackOverflowError String Symbol 
  Task Tuple Type TypeError TypeVar UInt UInt128 UInt16 UInt32 
  UInt64 UInt8 UndefInitializer UndefKeywordError UndefRefError 
  UndefVarError Union UnionAll Unsigned Vararg VecElement WeakRef 
  applicable eval fieldtype getfield ifelse invoke isa isdefined 
  nfields nothing setfield! throw tuple typeassert typeof undef
]]))
lex:add_style('core', lexer.STYLE_FUNCTION)


-- Base functions. julia> print(names(Base)) 
-- Except for the symbols, because they screw with the pattern matching
lex:add_rule('base', token(lexer.FUNCTION, word_match[[
  @MIME_str @__DIR__ @__FILE__ @__LINE__ @__MODULE__ @__dot__ @allocated 
  @assert @async @b_str @big_str @boundscheck @cfunction @cmd @debug 
  @deprecate @doc @elapsed @enum @error @eval @evalpoly @fastmath @generated 
  @gensym @goto @html_str @inbounds @info @inline @int128_str @isdefined 
  @label @macroexpand @macroexpand1 @noinline @nospecialize @polly @r_str 
  @raw_str @s_str @show @simd @specialize @static @sync @task @text_str 
  @threadcall @time @timed @timev @uint128_str @v_str @view @views @warn 
  ARGS AbstractChannel AbstractDict AbstractDisplay AbstractIrrational 
  AbstractMatrix AbstractRange AbstractSet AbstractUnitRange AbstractVecOrMat 
  AbstractVector Array Base BigFloat BigInt BitArray BitMatrix BitSet BitVector 
  Broadcast C_NULL CapturedException CartesianIndex CartesianIndices Cchar 
  Cdouble Cfloat Channel Cint Cintmax_t Clong Clonglong Cmd Colon Complex 
  ComplexF16 ComplexF32 ComplexF64 CompositeException Condition Cptrdiff_t 
  Cshort Csize_t Cssize_t Cstring Cuchar Cuint Cuintmax_t Culong Culonglong 
  Cushort Cwchar_t Cwstring DEPOT_PATH DenseMatrix DenseVecOrMat DenseVector 
  Dict DimensionMismatch Dims Docs ENDIAN_BOM ENV EOFError Enum 
  ExponentialBackOff GC HTML IOBuffer IOContext IOStream IdDict IndexCartesian 
  IndexLinear IndexStyle Inf Inf16 Inf32 Inf64 InsertionSort 
  InvalidStateException Irrational Iterators KeyError LOAD_PATH Libc 
  LinRange LinearIndices MIME MathConstants Matrix MergeSort Meta Missing 
  MissingException NTuple NaN NaN16 NaN32 NaN64 OrdinalRange PROGRAM_FILE 
  Pair PartialQuickSort PermutedDimsArray Pipe PipeBuffer 
  ProcessFailedException QuickSort Rational RawFD ReentrantLock Regex 
  RegexMatch RoundDown RoundFromZero RoundNearest RoundNearestTiesAway 
  RoundNearestTiesUp RoundToZero RoundUp RoundingMode Set Some StackTraces 
  StepRange StepRangeLen StridedArray StridedMatrix StridedVecOrMat 
  StridedVector StringIndexError SubArray SubString SubstitutionString Sys 
  SystemError TaskFailedException Text TextDisplay Threads Timer UnitRange 
  VERSION Val VecOrMat Vector VersionNumber WeakKeyDict __precompile__ 
  abs abs2 abspath accumulate accumulate! acos acosd acosh acot acotd acoth 
  acsc acscd acsch adjoint all all! allunique angle any any! append! argmax 
  argmin ascii asec asecd asech asin asind asinh asyncmap asyncmap! atan atand 
  atanh atexit atreplinit axes backtrace basename big bind binomial bitstring 
  broadcast broadcast! bswap bytes2hex bytesavailable cat catch_backtrace cbrt 
  cd ceil cglobal checkbounds checkindex chmod chomp chop chown circcopy! 
  circshift circshift! cis clamp clamp! cld close cmp coalesce code_lowered 
  code_typed codepoint codeunit codeunits collect complex conj conj! convert 
  copy copy! copysign copyto! cos cosc cosd cosh cospi cot cotd coth count 
  count_ones count_zeros countlines cp csc cscd csch ctime cumprod cumprod! 
  cumsum cumsum! current_task deepcopy deg2rad delete! deleteat! denominator 
  detach devnull diff digits digits! dirname disable_sigint display displayable 
  displaysize div divrem download dropdims dump eachcol eachindex eachline 
  eachmatch eachrow eachslice eltype empty empty! endswith enumerate eof eps 
  error esc escape_string evalfile evalpoly exit exp exp10 exp2 expanduser 
  expm1 exponent extrema factorial falses fd fdio fetch fieldcount fieldname 
  fieldnames fieldoffset fieldtypes filemode filesize fill fill! filter filter! 
  finalize finalizer findall findfirst findlast findmax findmax! findmin 
  findmin! findnext findprev first firstindex fld fld1 fldmod fldmod1 flipsign 
  float floatmax floatmin floor flush fma foldl foldr foreach frexp fullname 
  functionloc gcd gcdx gensym get get! get_zero_subnormals gethostname getindex 
  getkey getpid getproperty gperm hasfield hash haskey hasmethod hasproperty 
  hcat hex2bytes hex2bytes! homedir htol hton hvcat hypot identity ifelse 
  ignorestatus im imag in include_dependency include_string indexin insert! 
  instances intersect intersect! inv invmod invperm invpermute! isabspath 
  isabstracttype isapprox isascii isassigned isbits isbitstype isblockdev 
  ischardev iscntrl isconcretetype isconst isdigit isdir isdirpath 
  isdispatchtuple isempty isequal iseven isfifo isfile isfinite isimmutable 
  isinf isinteger isinteractive isless isletter islink islocked islowercase 
  ismarked ismissing ismount isnan isnothing isnumeric isodd isone isopen 
  ispath isperm ispow2 isprimitivetype isprint ispunct isqrt isreadable 
  isreadonly isready isreal issetequal issetgid issetuid issocket issorted 
  isspace issticky isstructtype issubnormal issubset istaskdone istaskfailed 
  istaskstarted istextmime isuppercase isvalid iswritable isxdigit iszero 
  iterate join joinpath keys keytype kill kron last lastindex lcm ldexp 
  leading_ones leading_zeros length lock log log10 log1p log2 lowercase 
  lowercasefirst lpad lstat lstrip ltoh macroexpand map map! mapfoldl mapfoldr 
  mapreduce mapslices mark match max maximum maximum! maxintfloat merge merge! 
  methods min minimum minimum! minmax missing mkdir mkpath mktemp mktempdir 
  mod mod1 mod2pi modf mtime muladd mv nameof names ncodeunits ndigits ndims 
  nextfloat nextind nextpow nextprod nonmissingtype normpath notify ntoh ntuple 
  numerator objectid occursin oftype one ones oneunit only open operm pairs 
  parent parentindices parentmodule parse partialsort partialsort! 
  partialsortperm partialsortperm! pathof permute! permutedims permutedims! 
  pi pipeline pkgdir pointer pointer_from_objref pop! popdisplay popfirst! 
  position powermod precision precompile prepend! prevfloat prevind prevpow 
  print println printstyled process_exited process_running prod prod! promote 
  promote_rule promote_shape promote_type propertynames push! pushdisplay 
  pushfirst! put! pwd rad2deg rand randn range rationalize read read! 
  readavailable readbytes! readchomp readdir readline readlines readlink 
  readuntil real realpath redirect_stderr redirect_stdin redirect_stdout 
  redisplay reduce reenable_sigint reim reinterpret relpath rem rem2pi 
  repeat replace replace! repr reset reshape resize! rethrow retry reverse 
  reverse! reverseind rm rot180 rotl90 rotr90 round rounding rpad rsplit 
  rstrip run schedule searchsorted searchsortedfirst searchsortedlast sec 
  secd sech seek seekend seekstart selectdim set_zero_subnormals setdiff 
  setdiff! setenv setindex! setprecision setproperty! setrounding show 
  showable showerror sign signbit signed significand similar sin sinc sincos 
  sincosd sind sinh sinpi size sizehint! sizeof skip skipchars skipmissing 
  sleep something sort sort! sortperm sortperm! sortslices splice! split 
  splitdir splitdrive splitext splitpath sprint sqrt stacktrace startswith 
  stat stderr stdin stdout step stride strides string strip success sum sum! 
  summary supertype symdiff symdiff! symlink systemerror take! tan tand tanh 
  task_local_storage tempdir tempname textwidth thisind time time_ns timedwait 
  titlecase to_indices touch trailing_ones trailing_zeros transcode transpose 
  trues trunc truncate trylock tryparse typeintersect typejoin typemax typemin 
  unescape_string union union! unique unique! unlock unmark unsafe_copyto! 
  unsafe_load unsafe_pointer_to_objref unsafe_read unsafe_store! unsafe_string 
  unsafe_trunc unsafe_wrap unsafe_write unsigned uperm uppercase uppercasefirst 
  valtype values vcat vec view wait walkdir which widemul widen withenv write 
  xor yield yieldto zero zeros zip
]]))
lex:add_style('base', lexer.STYLE_FUNCTION)

-- Luxor
lex:add_rule('luxor', token(lexer.CONSTANT, word_match[[
  @draw @eps @imagematrix @layer @pdf @png @polar @setcolor_str @svg
  BezierPath BezierPathSegment Blend BoundingBox Boxmaptile Circle Drawing 
  Forward GridHex GridRect HueShift Luxor Message Movie O Orientation 
  Partition Pen_opacity_random Pencolor Pendown Penup Penwidth Point Pop Push 
  Randomize_saturation Rectangle Reposition Scene Sequence Table Tiler Towards 
  Turn Turtle addstop animate arc arc2r arc2sagitta arrow arrowhead background 
  barchart bars between bezier beziercurvature bezierfrompoints 
  bezierpathtopoly bezierstroke beziertopoly bezier′ bezier′′ blend 
  blendadjust blendmatrix boundingbox boundingboxesintersect box 
  boxaspectratio boxbottom boxbottomcenter boxbottomleft boxbottomright 
  boxdiagonal boxheight boxmap boxmiddlecenter boxmiddleleft boxmiddleright 
  boxtop boxtopcenter boxtopleft boxtopright boxwidth brush cairotojuliamatrix 
  carc carc2r carc2sagitta center3pts circle circlepath circlepointtangent 
  circletangent2circles clip clippreserve clipreset closepath cm cropmarks 
  crossproduct curve dimension distance do_action dotproduct drawbezierpath 
  easeincirc easeincubic easeinexpo easeinoutbezier easeinoutcirc 
  easeinoutcubic easeinoutexpo easeinoutinversequad easeinoutquad 
  easeinoutquart easeinoutquint easeinoutsine easeinquad easeinquart 
  easeinquint easeinsine easeoutcirc easeoutcubic easeoutexpo easeoutquad 
  easeoutquart easeoutquint easeoutsine easingflat ellipse epitrochoid 
  fillpath fillpreserve fillstroke finish fontface fontsize getmatrix 
  getmode getnearestpointonline getpath getpathflat getrotation getscale 
  gettranslation grestore gsave highlightcells hypotrochoid image_as_matrix 
  inch initnoise insertvertices! intersectboundingboxes intersection 
  intersection2circles intersection_line_circle intersectioncirclecircle 
  intersectionlinecircle intersectionlines intersectlinepoly isarcclockwise 
  isinside ispointinsidetriangle ispointonline ispolyclockwise juliacircles 
  julialogo juliatocairomatrix label layoutgraph line lineartween 
  makebezierpath mask mesh midpoint mm move nearestindex newpath newsubpath 
  nextgridpoint ngon ngonside noise offsetpoly origin paint paint_with_alpha 
  paper_sizes pathtobezierpaths pathtopoly perpendicular pie placeimage 
  pointcrossesboundingbox pointinverse pointlinedistance polar poly polyarea 
  polycentroid polydistances polyfit polyintersect polyintersections polymove! 
  polyorientation polyperimeter polyportion polyreflect! polyremainder 
  polyremovecollinearpoints polyrotate! polysample polyscale! polysmooth 
  polysortbyangle polysortbydistance polysplit polytriangulate 
  polytriangulate! prettypoly preview randomcolor randomhue randompoint 
  randompointarray readpng rect rescale rline rmove rotate rotationmatrix 
  rule rulers scale scalingmatrix sector setantialias setbezierhandles 
  setblend setcolor setdash setfont setgray setgrey sethue setline setlinecap 
  setlinejoin setmatrix setmesh setmode setopacity settext shiftbezierhandles 
  simplify slope spiral splittext squircle star strokepath strokepreserve 
  text textbox textcentered textcentred textcurve textcurvecentered 
  textcurvecentred textextents textlines textoutlines textpath textright 
  texttrack textwrap transform translate translationmatrix
]]))
lex:add_style('luxor', lexer.STYLE_CONSTANT)

-- The names of user-defined fucntions should be highlighted
-- I want to match just the word that comes after the word 'function'
local user_defined_function = token(lexer.CONSTANT, 'function' * lexer.space^1 * lexer.word)
lex:add_rule('user_defined_function', user_defined_function)
lex:add_style('user_defined_function', lexer.STYLE_CONSTANT)

-- Symbols. Tokens beginning with a :colon
lex:add_rule('symbol', token(lexer.TYPE, ':' * lexer.word))
lex:add_style('symbol', lexer.STYLE_TYPE)

-- Identifiers. i.e. words, or variable names
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Strings.
lex:add_rule('string', token(lexer.STRING, lexer.delimited_range("'") +
                                           lexer.delimited_range('"')))

-- Comments.
lex:add_rule('comment', token(lexer.COMMENT, '#' * lexer.nonnewline^0))

-- Numbers.
lex:add_rule('number', token(lexer.NUMBER, lexer.float + lexer.integer))

-- Decorators. do I need this, if all the @functions are listed above? 
-- Probably not. Might be nice to make them a different color though, no?
--lex:add_rule('decorator', token('decorator', '@' * lexer.nonnewline^0))
--lex:add_style('decorator', lexer.STYLE_PREPROCESSOR)

-- Operators. Do I need this, if all (or most)of these are listed above already
lex:add_rule('operator', token(lexer.OPERATOR, S('{}[]()+-*/,.=')))

-- Fold points.
lex:add_fold_point(lexer.KEYWORD, 'function', 'end')
lex:add_fold_point(lexer.KEYWORD, 'for', 'end')
lex:add_fold_point(lexer.KEYWORD, 'if', 'end')
lex:add_fold_point(lexer.OPERATOR, '{', '}')
lex:add_fold_point(lexer.COMMENT, '#', lexer.fold_line_comments('#'))

return lex
