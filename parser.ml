type token =
  | LAMBDA
  | VAR of (string)
  | LPAREN
  | RPAREN
  | SEMICOLON

open Parsing;;
let _ = parse_error;;
# 7 "parser.mly"
  open Syntax
# 13 "parser.ml"
let yytransl_const = [|
  257 (* LAMBDA *);
  259 (* LPAREN *);
  260 (* RPAREN *);
  261 (* SEMICOLON *);
    0|]

let yytransl_block = [|
  258 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\001\000\002\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\008\000\000\000\000\000\004\000\
\000\000\000\000\001\000\007\000\005\000\003\000\006\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\008\000"

let yysindex = "\009\000\
\004\255\000\000\012\255\004\255\000\000\009\255\006\255\000\000\
\004\255\011\255\000\000\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\255\254\000\000\000\000\000\000\007\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\252\255\000\000\010\000"

let yytablesize = 17
let yytable = "\010\000\
\007\000\007\000\007\000\007\000\014\000\003\000\004\000\012\000\
\004\000\001\000\002\000\002\000\009\000\011\000\015\000\000\000\
\013\000"

let yycheck = "\004\000\
\002\001\003\001\004\001\005\001\009\000\002\001\003\001\002\001\
\003\001\001\000\004\001\005\001\001\001\005\001\004\001\255\255\
\007\000"

let yynames_const = "\
  LAMBDA\000\
  LPAREN\000\
  RPAREN\000\
  SEMICOLON\000\
  "

let yynames_block = "\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'term) in
    Obj.repr(
# 25 "parser.mly"
                    ( _1 )
# 78 "parser.ml"
               : Syntax.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'app) in
    Obj.repr(
# 28 "parser.mly"
               ( _1 )
# 85 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 29 "parser.mly"
                      ( Abs(_1,_3) )
# 93 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 32 "parser.mly"
           ( _1 )
# 100 "parser.ml"
               : 'app))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'app) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 33 "parser.mly"
              ( App(_1,_2) )
# 108 "parser.ml"
               : 'app))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'term) in
    Obj.repr(
# 36 "parser.mly"
                        ( _2 )
# 115 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 37 "parser.mly"
         ( Var(_1) )
# 122 "parser.ml"
               : 'atom))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.term)
