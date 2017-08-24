(* A term is a variable, abstraction or application. *)

(* Ordinary term. Var and Abs include the string representation of the (bound) variable *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

(* De bruijn representation of term. Variables are encoded as de bruijn index, which is the nesting depth of the bounded lambda *)
type nameless_term =
  | Variable of int
  | Lambda of nameless_term
  | Apply of nameless_term * nameless_term

(* Naming context of unbound variables. de bruijn index of var = str index + nesting depth *)
let context = [("x", 0), ("y", 1), ("z", 2), ("a", 3), ("b", 4)]

(* given an ordinary term, a naming context and current lambda depth, return the index for a free variable *)
let freevar_index oterm context depth = match oterm with
  | Var(str) -> (List.assoc str context) + depth
  | Abs(str,_) -> (List.assoc str context) + depth

(* Ordinary term to nameless term *)
(* binderlist is a list of (boundvar string, depth) *)
let removenames ot context =
  let rec helper ot context binderlist depth =
    match ot with
    | Var(str) ->
       if List.mem_assoc str binderlist
       then Variable(List.assoc str binderlist)
       else Variable(freevar_index ot context depth)
    | Abs(str, absbody) ->
       let binderlist = List.map (fun (s,d) -> (s,d+1)) binderlist in
       let binderlist' = (str,0)::binderlist in
       Lambda(helper absbody context binderlist' (depth+1))
    | App(t1, t2) ->
       let t1' = helper t1 context binderlist depth
       and t2' = helper t2 context binderlist depth in
       Apply(t1', t2')
  in helper ot context [] 0
  
let restorenames nt context =
  let rec helper nt context depth =
    match nt with
    | Variable(i) ->
    | Lambda(i) ->
    | Apply(t1, t2) ->
  in helper nt context 0
