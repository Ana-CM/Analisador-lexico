/*
* Ana Carolina Mendes Lino 201865212AC
* Thiago Silva Miranda 201865553C
*/

public class Token {

      public int line, column;
      public TOKEN_TYPE token;
      public String lexeme;
      public Object info;

      public Token( TOKEN_TYPE token, String lexeme, Object object, int line, int column ) {
            this.token  = token;
            this.lexeme = lexeme;
            this.info   = object;
            this.line   = line;
            this.column = column;
      }

      public Token( TOKEN_TYPE token, String lexeme, int line, int column ) {
            this.token  = token;
            this.lexeme = lexeme;
            this.info   = null;
            this.line   = line;
            this.column = column;
      }

      public Token( TOKEN_TYPE token, Object object, int line, int column ) { 
            this.token  = token;
            this.lexeme = "";
            this.info   = object;
            this.line   = line;
            this.column = column;
      }

      @Override
      public String toString(){
            return "[(" + line + "," + column + ") \"" + lexeme + "\" : <" + (info == null ? "" : info.toString() ) + "> " + token +"]";
      }
}

 
