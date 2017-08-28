{
  open Parser
  exception Eof
}

rule token = parse
    [' ' '\t' '\n']     { token lexbuf }
  | "("        {LPAREN}
  | ")"        {RPAREN}
  | "\\"       {LAMBDA}
  | ['a'-'z']  {VAR(Lexing.lexeme lexbuf)}
  | ";"        {SEMICOLON}
  | eof     {raise Eof}
