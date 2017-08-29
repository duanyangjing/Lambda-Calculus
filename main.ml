open Syntax

let _ =
  try
    while true do
      print_string "> ";
      flush stdout;
      let lexbuf = Lexing.from_channel stdin in
      let ot = Parser.main Lexer.token lexbuf in
      let nt = Syntax.removenames ot Syntax.context in
      let result = eval nt in
      print_ot ot; print_string "\n";
      print_nt nt; print_string "\n";
      print_nt result; print_string "\n"; flush stdout
    done
  with Lexer.Eof ->
    exit 0
  
      
