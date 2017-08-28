open Syntax

let _ =
  try
    while true do
      print_string "> ";
      flush stdout;
      let lexbuf = Lexing.from_channel stdin in
      let result = Parser.main Lexer.token lexbuf in
      print_ot result; print_string "\n"; flush stdout
    done
  with Lexer.Eof ->
    exit 0
  
      
