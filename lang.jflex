
%%

%unicode
%line
%column
%class Lexer
%function nextToken
%type Token

%{
    /* 
     * Código arbitrário pode ser inserido diretamente no analisador dessa forma. 
     * Aqui podemos declarar variáveis e métodos adicionais que julgarmos necessários. 
     */
    private int numberTokens;
    
    public int readedTokens(){
       return numberTokens;
    }

    private Token symbol( TOKEN_TYPE tokenType ) {
        numberTokens++;
        return new Token( tokenType, yytext(), yyline+1, yycolumn+1 );
    }

    private Token symbol( TOKEN_TYPE tokenType, Object value ) {
        numberTokens++;
        return new Token( tokenType, value, yyline+1, yycolumn+1 );
    }
%}

%init{
    numberTokens = 0; // Isto é copiado direto no construtor do lexer. 
%init}

  
  /**
   * Definição dos tokens que serão reconhecidos pelo analisador.
   */ 
  FimLinha         = \r|\n|\r\n
  Brancos          = {FimLinha} | [\t\n\r\f\v\s]
  PontoFlutuante   = [:digit:]*[.] [:digit:]+ 
  Inteiro          = [:digit:] [:digit:]*
  Logico           = "true" | "false"
  Identificador    = [:lowercase:] ( [:letter:] | [:digit:] | "_" )*
  Tipo             = [:uppercase:] ( [:letter:] | [:digit:] | "_" )*
  LiteralCaractere = "'" ([:letter:] | \n | \t | \b | \r | "\\" ) "'"
  ComentarioLinha  = "--" (.)* {FimLinha}
%state COMMENT

%%
<YYINITIAL>{
    "null"             { return symbol(TOKEN_TYPE.NULL); }
    "return"           { return symbol(TOKEN_TYPE.RETURN); }
    "new"              { return symbol(TOKEN_TYPE.NEW); }
    "if"               { return symbol(TOKEN_TYPE.IF); }
    "else"             { return symbol(TOKEN_TYPE.ELSE); }
    "iterate"          { return symbol(TOKEN_TYPE.ITERATE); }
    "print"            { return symbol(TOKEN_TYPE.PRINT); }
    "read"             { return symbol(TOKEN_TYPE.READ); }
    "data"             { return symbol(TOKEN_TYPE.DATA); }
    {Logico}           { return symbol(TOKEN_TYPE.LOG, Boolean.parseBoolean(yytext()) ); }
    {Identificador}    { return symbol(TOKEN_TYPE.ID); }
    {Inteiro}          { return symbol(TOKEN_TYPE.NUM, Integer.parseInt(yytext()) ); }
    {PontoFlutuante}   { return symbol(TOKEN_TYPE.NUM, Double.parseDouble(yytext()) ); }
    {LiteralCaractere} { return symbol(TOKEN_TYPE.CHR, yytext().substring(1, yytext().length()-1) ); }
    {Tipo}             { return symbol(TOKEN_TYPE.TYPE); }
    "::"               { return symbol(TOKEN_TYPE.COLONCOLON); }
    ":"                { return symbol(TOKEN_TYPE.COLON); }
    "("                { return symbol(TOKEN_TYPE.LPAR); }
    ")"                { return symbol(TOKEN_TYPE.RPAR); }
    "["                { return symbol(TOKEN_TYPE.LBRACK); }
    "]"                { return symbol(TOKEN_TYPE.RBRACK); }
    "{"                { return symbol(TOKEN_TYPE.LBRACE); }
    "}"                { return symbol(TOKEN_TYPE.RBRACE); }
    ">"                { return symbol(TOKEN_TYPE.GT); }
    "<"                { return symbol(TOKEN_TYPE.LT); }
    ";"                { return symbol(TOKEN_TYPE.SEMI); }
    "."                { return symbol(TOKEN_TYPE.DOT); }
    ","                { return symbol(TOKEN_TYPE.COMMA); }
    "="                { return symbol(TOKEN_TYPE.EQ); } 
    "=="               { return symbol(TOKEN_TYPE.EQEQ); }
    "!="               { return symbol(TOKEN_TYPE.NE); }
    "+"                { return symbol(TOKEN_TYPE.PLUS); }
    "-"                { return symbol(TOKEN_TYPE.MINUS); }
    "*"                { return symbol(TOKEN_TYPE.TIMES); }
    "/"                { return symbol(TOKEN_TYPE.DIV); }
    "%"                { return symbol(TOKEN_TYPE.MOD); }
    "&&"               { return symbol(TOKEN_TYPE.AND); }
    "!"                { return symbol(TOKEN_TYPE.NOT); }
    "{-"               { yybegin(COMMENT); }
    {Brancos}          { /* Não faz nada  */ }
    {ComentarioLinha}  { /* Não faz nada  */ }
}

<COMMENT>{
   "-}"     { yybegin(YYINITIAL); } 
   [^"-}"]* {                     }
}

[^] { throw new RuntimeException("Illegal character <"+yytext()+"> at " + yyline + ":" + yycolumn); }