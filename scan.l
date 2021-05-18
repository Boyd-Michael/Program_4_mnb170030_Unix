/*
 * Filename:       scan.l
 * Date:           04/03/2020
 * Author:         Michael Boyd
 * Email:          mnb170030@utdallas.edu
 * Version:        1.3
 * Copyright:      2020, All Rights Reserved
 *
 * Description:
 *
 *       Lex Program for definding vaules.
 *
 */

%option noyywrap
%option nounput
%option noinput

%{
  #include <stdlib.h>
  #include "y.tab.h"
%}

%%

[IVXLM]+                     {return BISON_ROMAN; }
[A-Za-z]+                    {return BISON_NAME; }
[A-Z"."]+                    {return BISON_NAME_INITIAL; } 
"Sr."                        {return BISON_SR; }
"Jr."                        {return BISON_JR; }
"\n"                         {return BISON_NEWLINE; }
[0-9]+                       {return BISON_INT; }
","                          {return BISON_COMMA; }
"-"                          {return BISON_DASH; }
"#"                          {return BISON_HASH; }
[A-Za-z0-9]+                 {return BISON_IDENTIFIER; }


%%

