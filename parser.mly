/* grammer for the parser. Run
 * ocamlyacc parser.mly
 * to generate parser.ml automatically from this file
 */
       
%{
  open Syntax
%}

/* terminal symbols */
%token LAMBDA
%token DOT
%token <string> VAR
%token LPAREN
%token RPAREN
%token EOL

/* entry point of the parser */
%start main
%type <context -> (term * context)> main

     
%%
/* main is just one lambda term */
main:
  term EOL     { $1 }

term:
     app       { $1 }
   | LAMBDA VAR DOT term  { Abs($2,$4) }

app:
     atom  { $1 }
   | app atom { App($1,$2) }

atom:
     LPAREN term RPAREN { $2 }
   | VAR { Var($1) }
