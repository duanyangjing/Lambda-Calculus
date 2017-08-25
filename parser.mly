/* grammer for the parser. Run
 * ocamlyacc parser.mly
 * to generate parser.ml automatically from this file
 */
       
%{
  open Syntax
%}

/* terminal symbols */
%token LAMBDA
%token <string> VAR
%token LPAREN
%token RPAREN
%token SEMICOLON

/* entry point of the parser */
%start main
%type <Syntax.term> main

     
%%
/* main is just one lambda term ended with semicolon */
main:
     term SEMICOLON { $1 }

term:
     app       { $1 }
   | VAR LAMBDA term  { Abs($1,$3) }

app:
     atom  { $1 }
   | app atom { App($1,$2) }

atom:
     LPAREN term RPAREN { $2 }
   | VAR { Var($1) }
