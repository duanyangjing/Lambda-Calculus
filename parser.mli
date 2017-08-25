type token =
  | LAMBDA
  | VAR of (string)
  | LPAREN
  | RPAREN
  | SEMICOLON

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.term
