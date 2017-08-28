(* A term is a variable, abstraction or application. *)

(* Ordinary term. Var and Abs include the string representation of the (bound) variable *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

(* De bruijn representation of term. Variables are encoded as de bruijn index, which is the nesting depth of the bound lambda *)
type nameless_term =
  | Variable of int
  | Lambda of string * nameless_term
  | Apply of nameless_term * nameless_term

(* Naming context of unbound variables. de bruijn index of var = str index + nesting depth *)
let context = [("x", 0); ("y", 1); ("z", 2); ("a", 3); ("b", 4)]

(* given an ordinary term, a naming context and current lambda depth, return the index for a free variable *)
let freevar_index oterm context depth = match oterm with
  | Var(str) -> (List.assoc str context) + depth
  | Abs(str,_) -> (List.assoc str context) + depth

(* Ordinary term to nameless term *)
(* 
binderlist is a list of (boundvar string, depth), for example:
λx.x — [(x,0)]
λx.λy.x — [(x,1);(y,0)]
the associated depth is the de bruijn index for bound variables.

Under this setting λx.λx.x yields binderlist [(x,0);(x,1)]. Because List.mem_assoc finds the
first matching key, var x still maps to index 0, which is correct. Strictly speaking alpha 
conversion might be needed in this case.
*)
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
       Lambda(str, helper absbody context binderlist' (depth+1))
    | App(t1, t2) ->
       let t1' = helper t1 context binderlist depth
       and t2' = helper t2 context binderlist depth in
       Apply(t1', t2')
  in helper ot context [] 0 

(* Print out the ordinary term given an ordinary term*)
let rec print_ot ot =
  match ot with
    Var(str) -> print_string str
  | Abs(str,term) ->
     print_string "(";
     print_string (str ^ "\\ ");
     print_ot term;
     print_string ")"
  | App(t1,t2) ->
     print_string "(";
     print_ot t1;
     print_string " ";
     print_ot t2;
     print_string ")"
  

(* Shifting -- renumber indices of free variables in substitution*)
(* d is the offset to shift, c is the cut off to distinguish bound vars within nt*)
let rec termshift t d c =
  match t with
    Variable(k) -> if k < c then Variable k else Variable (k+d)
  | Lambda(s,t) -> Lambda(s,termshift t d (c+1))
  | Apply(t1,t2) -> Apply(termshift t1 d c,termshift t2 d c)

(* Substitution -- defined based on shifting *)
(* [x -> s]t *)
let rec substitute x s t = match x with Variable(x') ->
  match t with
    Variable(k) -> if k = x' then t else Variable k
  | Lambda(str,t) -> Lambda(str, substitute (Variable(x'+1)) (termshift s 1 0) t)
  | Apply(t1,t2) -> Apply(substitute x s t1, substitute x s t2)

(* TODO: not sure how to understand figure 5.3 *)
let rec eval t =
  match t with
    Variable(k) -> t
  | Lambda(s,t) -> Lambda(s,eval t)
  | Apply(Lambda(str,t),s) ->
     let s' = termshift s 1 0 in
     let ret = substitute (Variable 0) s' t in
     termshift ret (-1) 0
  | Apply(t1,t2) ->
     let t1' = eval t1
     and t2' = eval t2 in
     eval (Apply(t1', t2')) 
