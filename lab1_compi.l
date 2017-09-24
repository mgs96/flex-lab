/* Includes y definiciones de variables */
%{
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int i=1;
char *ids[1000];
int errores=0;
%}

/* Definiciones Regulares */
boolean     True|true|TRUE|False|false|FALSE
pal_reser   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|range|{boolean}
operadores  [+]|[-]|[*]|[*][*]|[/]|[/][/]|[%]|[<][<]|[>][>]|[&]|[|]|(^)|[~][<]|[>]|[<][=]|[>][=]|[=][=]|[!][=]|[<][>]
delimitador [[]|[]]|[;]|[:]|[.]|[,]|[>][>][=]|[<][<][=]|[+][=]|[-][=]|[*][=]|[/][=]|[/][/][=]|[&][=]|[*][*][=]|[%][=]
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
string      [\"'‘][^"'‘’]*[\"'’]
comentario  [#].+
asign       [=]
error       ({entero}{variable})|[^({boolean}|{pal_reser}|{operadores}|{delimitador}|{numeros}|{entero}|{decimal}|{exp}|{img}|{logint}|{reales}|{variable}|{string}|{comentario}|{asign}|“ ”|t|\n)]|({operadores}{operadores})
/*Definiciones Regulares \["'‘][^"'‘’]*\["'’]*/

/* Reglas */

%%
{pal_reser}   { int i;
                for (i=0;i<yyleng;i++){
                  printf ("%c",toupper(yytext[i]));
                }
                printf (" ");
              }
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
[+]           {printf("suma= %s ",yytext);}
[-]           {printf("menos= %s ",yytext);}
[*]           {printf("mult= %s ",yytext);}
[*][*]|(^)    {printf("potencia= %s ",yytext);}
{asign}       {printf("asig= %s ",yytext);}
[/]           {printf("div= %s ",yytext);}
[/][/]        {printf("%s es un op_div_entera ",yytext);}
[%]           {printf("%s es un op_mod ",yytext);}
[<][<]        {printf("%s es un muy_menor ",yytext);}
[>][>]        {printf("%s es un muy_mayor ",yytext);}
[&]           {printf("%s es un and ",yytext);}
[~]           {printf("%s es un negacion ",yytext);}
[<]           {printf("%s es un menor ",yytext);}
[>]           {printf("%s es un mayor ",yytext);}
[<][=]        {printf("menor_ig=%s ",yytext);}
[>][=]        {printf("mayor_ig=%s ",yytext);}
[=][=]        {printf("comp= %s ",yytext);}
[!][=]        {printf("%s es un diferente ",yytext);}
[<][>]        {printf("%s es un diferente ",yytext);}
[(]           {printf("parabre=%s ",yytext);}
[)]           {printf("parcierr=%s ",yytext);}
[,]           {printf("coma=%s ",yytext);}
{variable}    {
                 if(i==1){
                    ids[i]=strdup(yytext);
                    printf("id%d=%s ",i,ids[i]);
                    i++;
                 }else{
                    int sw=0;
                    int j=1;
                    int pos=0;
                    while(j<i && sw != 1){
                      if(strcmp(ids[j],strdup(yytext)) == 0){
                        sw=1;
                        pos=j;
                        j=i+i;
                      }
                      j++;
                    }
                    if(sw==0){
                      ids[i]=strdup(yytext);
                      printf("id%d=%s ",i,ids[i]);
                      i++;
                    }else{
                      printf("id%d=%s ",pos,ids[pos]);
                    }
                 }
              }
{entero}      {printf("entero=%s ",yytext);}
{decimal}     {printf("decimal=%s ",yytext);}
{exp}         {printf("real=%s ",yytext);}
{img}         {printf("imaginario=%s ",yytext);}
{logint}      {printf("long=%s ",yytext);}
{string}      {printf("cadena=%s ",yytext);}
{error}       {printf("Error=%s ",yytext);errores++;}
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
  int k;
  for(k=1;k<i;k++){
    printf("id%d = %s \n",k,ids[k]);
  }
  printf("\nTotal identificadores: %d \n \n",i-1);
  printf("Error(es): %d \n",errores);
}

/* Codigo C */