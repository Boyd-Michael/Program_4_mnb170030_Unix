/*
 * Filename:    program4.c
 * Date:        4/3/2020
 * Author:      Michael Boyd
 * Email:       mnb170030@utdallas.edu
 * Version:     1.7
 * Copyright:   2020, All Rights Reserved 
 *
 * Description:
 *
 *   Calls yylex or yyparse.
 */

#include <stdio.h>
#include <string.h>
#include "program4.h"
#include "y.tab.h"

//using namespace std;

int yylex(void);
int yyparse(void);
extern char *yytext;


int main(int argc, char **argv)
{
  printf("\nargc=%s.\n\n", argv[0]);
  int token;

  if(strcmp(argv[0], "./scanner") == 0)
    {
      token = yylex();
      
      while(token != 0)
	{
	  printf("The Token has the integer value %d.\n", token);
	  printf("\tThis token corresponds to: ");

	  switch(token)
	    {
	    case BISON_NAME:
	      printf("NameToken\n");
	      printf("\tThe Name string was: %s\n", yytext);
	      break;
	    case BISON_IDENTIFIER:
	      printf("IdentifierToken\n");
	      break;
	    case BISON_NAME_INITIAL:
	      printf("Name_Initial_Token\n");
	      printf("\tThe Intitial string was: %s\n", yytext);
	      break;
	    case BISON_ROMAN:
	      printf("RomanToken\n");
	      break;
	    case BISON_SR:
	      printf("SrToken\n");
	      break;
	    case BISON_JR:
	      printf("JrToken\n");
	      break;
	    case BISON_NEWLINE:
	      printf("EOLToken\n");
	      break;
	    case BISON_INT:
	      printf("IntToken\n");
	      printf("\tThe integer string was: %s\n", yytext);
	      break;
	    case BISON_COMMA:
	      printf("CommaToken\n");
	      break;
	    case BISON_DASH:
	      printf("DashToken\n");
	      break;
	    case BISON_HASH:
	      printf("HashToken\n");
	      break;
	    default:
	      printf("UNKNOWN\n");
	    }
	  token = yylex();

	}
    }
  else if(strcmp(argv[0], "./parser")==0)
     {
       printf("Starting Parser\n\n\n");
       return ( yyparse());
     }
  else
    yyparse();
  printf("Done!");
  return 0;

}
