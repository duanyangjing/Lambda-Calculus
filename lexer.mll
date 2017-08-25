{
  open Parser
  exception Eof
}

rule token = parse
    [' ' '\t' '\n']     { token lexbuf }
  | "("        {LPAREN}
  | ")"        {RPAREN}
  | "\\"       {LAMBDA}
  | ['a'-'z']  {VAR (lexeme lexbuf)}
  | eof     {raise Eof}
