import java.io.FileReader;
import java.io.IOException;

public class Teste{
     public static void main( String args[] ) throws IOException {

          Lexer lx     = new Lexer( new FileReader( args[0] ) );
          Token token  = lx.nextToken();

          while( null != token ) {
              System.out.println( token.toString() );
              token = lx.nextToken();
          }

          System.out.println("Total de tokens lidos " + lx.readedTokens());
     }
}
