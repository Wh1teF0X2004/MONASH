/*  flex  file for lexical analyser for PLUS-TIMES-POWER expressions,
    which involve simple arithmetic for nonnegative integers
    with addition, multiplication and powers.
    Graham Farr, Monash University
    Initially, copied from the Wikipedia page for  lex, then modified over time.
    Last updated:  11 September 2021
*/
    
/*** Definition section ***/

%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
#include "quant.h"

#include "y.tab.h"

%}


%%
    /*** Rules section ***/

            /* yytext is a string containing the matched text. */
k0   {
            /* printf("Token: k0;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return k0;

        }

k1   {
            /* printf("Token: k1;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return k1;

        }

CNOT   {
            /* printf("Token: CNOT;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return CNOT;

        }

TOF   {
            /* printf("Token: TOF;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return TOF;

        }

"(x)"   {
            /* printf("Token: KRONECKERPROD;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return KRONECKERPROD;

        }

I   {
            /* printf("Token: I;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return I;

        }

H   {
            /* printf("Token: H;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return H;

        }

X   {
            /* printf("Token: X;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return X;

        }

Z   {
            /* printf("Token: Z;  Lexeme: %s\n", yytext); */

            yylval.num = atof(yytext);
            return Z;

        }

[*()]   {
            /* printf("Token and Lexeme: %s\n", yytext); */

            return  *yytext;

        }

\n      {
            /* printf("Token and Lexeme: <newline>\n"); */

            return  *yytext;

        }


[ \t]   {    }     /*  skip whitespace  */


.       {
           /* printf("Invalid character.\n"); */

           yyerror("invalid character");

        }
     /*  will match any single character that does not match
         any of the above patterns
     */


%%
    /*** C Code section ***/

void yyerror(char *s) {
      fprintf(stderr, "line %d: yytext = %s.  Error msg: %s.\n", yylineno, yytext, s);
}


int yywrap(void) {
   return 1;
}


/*  comment out the function  main()  if using  lex  with  yacc   */
/* int main(void) {
    yylex();
    return 0;
} */
