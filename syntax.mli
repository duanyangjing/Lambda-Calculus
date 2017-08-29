type term =
  | Var of string
  | Abs of string * term
  | App of term * term

type nameless_term =
  | Variable of int
  | Lambda of string * nameless_term
  | Apply of nameless_term * nameless_term
      
val print_ot: term -> unit
  
val context: (string * int) list

val removenames: term -> (string * int) list -> nameless_term
val print_nt: nameless_term -> unit
val eval: nameless_term -> nameless_term
