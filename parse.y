/*
 * Filename:   parse.y
 * Date:       4/4/2020
 * Author:     Michaeal Boyd
 * Email:      mnb170030@utdallas.edu
 * Version:    1.3
 * Copyright:  2020, All Rights Reserved
 *
 *
 * Description:
 *
 *    Creating a parser.
 */

%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *);
  
  extern int sjpline;
  extern char *yytext;
 %}

%union
 {
   int value;
   char *str;
}

%type    <value>   BISON_INT
%type    <str>     BISON_NAME
%type    <str>     BISON_NAME_INITIAL
%type    <str>     BISON_IDENTIFIER
%type    <str>     BISON_ROMAN

%token  BISON_NAME
%token  BISON_NAME_INITIAL
%token  BISON_SR
%token  BISON_JR
%token  BISON_ROMAN
%token  BISON_IDENTIFIER
%token  BISON_INT
%token  BISON_HASH
%token  BISON_COMMA
%token  BISON_NEWLINE
%token  BISON_DASH


%%


postal_addresses: address_block BISON_NEWLINE {fprintf(stdout, "\n"); } postal_addresses
| address_block
;

address_block: name_part street_address location_part
;

name_part: personal_part last_name suffix_part BISON_NEWLINE
| personal_part last_name BISON_NEWLINE
| error BISON_NEWLINE
;

location_part: town_name BISON_COMMA state_code zip_code BISON_NEWLINE
| error BISON_NEWLINE
;

street_address: street_number street_name BISON_INT {fprintf(stdout, "<AptNum>%s</AptNum>\n", yytext); } BISON_NEWLINE
| street_number street_name BISON_HASH BISON_INT {fprintf(stdout, "<AptNum>%s</AptNum>\n", yytext); } BISON_NEWLINE
| street_number street_name BISON_NEWLINE
| error BISON_NEWLINE
;


personal_part: BISON_NAME {fprintf(stdout,"<FirstName>%s</FirstName>\n", yytext); }
| BISON_NAME_INITIAL {fprintf(stdout, "<FirstName>%s</FirstName>\n", yytext); }
;

last_name: BISON_NAME {fprintf(stdout, "<LastName>%s</LastName>\n", yytext); }
;

suffix_part: BISON_SR {fprintf(stdout, "<Suffix>%s</Suffix>\n", yytext); }
| BISON_JR {fprintf(stdout, "<Suffix>%s</Suffix>\n", yytext); }
| BISON_ROMAN {fprintf(stdout, "<Suffix>%s</Suffix>\n", yytext); }
;

street_number: BISON_INT {fprintf(stdout, "<StreetNum>%s</StreetNum>\n", yytext); }
| BISON_IDENTIFIER {fprintf(stdout, "<StreetNum>%s</StreetNum>\n", yytext); }
;

street_name: BISON_NAME {fprintf(stdout, "<StreetName>%s</StreetName>\n", yytext); }
;

town_name: BISON_NAME {fprintf(stdout, "<City>%s</City>\n", yytext); }
;

state_code: BISON_NAME {fprintf(stdout, "<State>%s</State>\n", yytext); }
;


zip_code: BISON_INT {fprintf(stdout, "<Zip5%s</Zip5>\n>", yytext); } BISON_DASH BISON_INT {fprintf(stdout, "<Zip4>%s</Zip4>\n", yytext); }
| BISON_INT {fprintf(stdout, "<Zip5>%s</Zip5>\n", yytext); }
;
/*
zip_code: BISON_INT {fprintf(stdout, "<Zip5>%s</Zip5>\n", yytext); }
| BISON_INT {fprintf(stdout, "<Zip5>%s</Zip5>\n", yytext); } BISON_DASH BISON_INT {fprintf(stdout, "<Zip4>%s</Zip4>\n"); }
;
*/
%%

void yyerror(char *s)
{
 fprintf( stdout, "\nError in inputfile %s\n", s);
}
