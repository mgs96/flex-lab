/* Includes y definiciones de variables */
%{
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int i=1;
char* ids[1000];
int size=0;
%}

/* Definiciones Regulares */
boolean     True|true|TRUE|False|false|FALSE
pal_reser   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|range|{boolean}
operadores  [+]|[-]|[*]|[*][*]|[/]|[/][/]|[%]|[<][<]|[>][>]|[&]|[|]|[^]|[~][<]|[>]|[<][=]|[>][=]|[=][=]|[!][=]|[<][>]
delimitador [[]|[]]|[;]|[:]|[.]|[>][>][=]|[<][<][=]|[+][=]|[-][=]|[*][=]|[/][=]|[/][/][=]|[&][=]|[*][*][=]|[%][=]
numero      [0-9]
numeros     {numero}+
entero      ([-])?{numeros}
decimal     {entero}(.{numeros})?
exp         {decimal}(e([-]|[+])?{numeros})?
img         ({entero}|{decimal})(j|J)
logint      {entero}(l|L)
reales      {exp}|{img}|{logint}
letra       [_a-zA-Z]
caracter    [_a-zA-Z0-9]*
variable    {letra}{caracter}
string      (["](.+)["])|(['](.+)['])|([‘](.+)[^‘][’])
comentario  [#].+
asign       [=]
/*Definiciones Regulares*/

/* Reglas */

%%
{pal_reser}   { int i;
                for (i=0;i<yyleng;i++) 
                printf ("%c",toupper(yytext[i]));
                printf (" ");}
[[]           {printf("corch_abre=%s ",yytext);}
[]]           {printf("corch_cierra=%s ",yytext);}
[;]           {printf("punto_coma=%s ",yytext);}
[:]           {printf("dospuntos=%s ",yytext);}
[>][>][=]     
[<][<][=]     
[+][=]        
[-][=]        
[*][=]        
[/][=]        
[/][/][=]     
[&][=]        
[*][*][=]     
[%][=]        
[+]           {printf("%s es un op_suma ",yytext);}
[-]           {printf("%s es un op_resta ",yytext);}
[*]           {printf("%s es un op_mult ",yytext);}
[*][*]        {printf("%s es un op_pot ",yytext);}
{asign}       {printf("asig= %s",yytext);}
[/]           {printf("%s es un op_div ",yytext);}
[/][/]        {printf("%s es un op_npi ",yytext);}
[%]           {printf("%s es un op_mod ",yytext);}
[<][<]        {printf("%s es un muy_menor ",yytext);}
[>][>]        {printf("%s es un muy_mayor ",yytext);}
[&]           {printf("%s es un and ",yytext);}
[~]           {printf("%s es un negacion ",yytext);}
[<]           {printf("%s es un menor ",yytext);}
[>]           {printf("%s es un mayor ",yytext);}
[<][=]        {printf("%s es un menor_igual ",yytext);}
[>][=]        {printf("%s es un mayor_igual ",yytext);}
[=][=]        {printf("%s es un igual ",yytext);}
[!][=]        {printf("%s es un diferente ",yytext);}
[<][>]        {printf("%s es un diferente ",yytext);}
[(]           {printf("parabre=%s",yytext);}
[)]           {printf("parcierr=%s",yytext);}
[,]           {printf("coma=%s",yytext);}
{variable}    {
               if(i==1){
                  ids[i]=yytext;
                  printf("id%d=%s ",i,ids[i]);
                  i++;
               }else{
                  int sw=0;
                  int j=1;
                  while(j<i && sw != 1){
                    //Falla la comparacion
                    if(strcmp(ids[j],yytext) == 0){
                      sw=1;
                      j=i+i;
                    }
                    j++;
                  }
                  if(sw==0){
                    ids[i]=yytext;
                    printf("id%d=%s ",i,ids[i]);
                    i++;
                  }
               }
              }
{entero}      {printf("%s es un entero ",yytext);}
{decimal}     {printf("%s es un decimal ",yytext);}
{exp}         {printf("%s es un real ",yytext);}
{img}         {printf("%s es un imaginario ",yytext);}
{logint}      {printf("%s es un loginteger ",yytext);}
{string}      {printf("%s es un String ",yytext);}
{comentario}  
. |\n
%%

/* Reglas */

/* Codigo C */

main(int argc, char *argv[]){
  if(argc != 2){
    printf("Falta archivo <./a.out 'filename'> \n");
    exit(0);
  }
  yyin=fopen(argv[1],"r");
  yylex();
  printf("\n");
  printf("total: %d \n",i-1);
}

/* Codigo C */