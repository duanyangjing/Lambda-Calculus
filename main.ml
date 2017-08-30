open Syntax

let _ =
  try
    while true do
      print_string "> ";
      flush stdout;
      let lexbuf = Lexing.from_channel stdin in
      let ot = Parser.main Lexer.token lexbuf in
      let nt = Syntax.removenames ot Syntax.context in
      let nt' = eval nt in
      let result = restorenames nt' context in
      print_string "parsed ordinary term: "; print_ot ot; print_string "\n";
      print_string "corresponding nameless term: "; print_nt nt; print_string "\n";
      print_string "evaluated nameless term: "; print_nt nt'; print_string "\n";
      print_string "evaluated ordinary term: "; print_ot result; print_string "\n";
      flush stdout
    done
  with Lexer.Eof ->
    exit 0
  
      
