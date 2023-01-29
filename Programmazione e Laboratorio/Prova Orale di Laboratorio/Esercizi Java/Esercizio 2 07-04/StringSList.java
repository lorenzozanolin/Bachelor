package Lezione070420;

public class StringSList //classe per rappresentare liste di stringhe
{  
   public static final StringSList NULL_STRINGLIST = new StringSList();
   private String first; //primo elemento della lista
   private StringSList rest; //resto della lista
   private boolean empty; 
    
   public StringSList()
   {
      empty=true;
      first="";
      rest=null;
    }
  
   public StringSList(String e, StringSList sl)
   {
      empty=false;
      first=e;
      rest=sl;
   }
   
   public boolean isNull()
   {
      return empty; 
   }
   
   public String car()
   {
       return first;
   }
   
   public StringSList cdr()
   {
       return rest;
   }
   
   public StringSList cons(String e)
   {
       return (new StringSList (e,this)); //this e' la lista corrente
   }
   
   public int length()
   {
        if (isNull())
        return 0;
       else
        return 1 + this.cdr().length();       
   }
   
   public String listRef(int k)
   {
       if(k==0)
        return this.car();
       else
        return this.cdr().listRef(k-1);
   }
   
   public boolean equals(StringSList sl)
   {
       if(isNull())
        return sl.isNull();
       if (sl.isNull())
        return false;
        
       if(this.car().equals(sl.car()))
         return this.cdr().equals(sl.cdr());
       else 
         return false;
   }
   
   public StringSList append(StringSList sl)
   {
       if(isNull())
         return sl;
        
       else
         return cdr().append(sl).cons(car());
   }
   
   public StringSList reverse()
   {
       return reverseRec(NULL_STRINGLIST);
   }
   
   private StringSList reverseRec(StringSList rl)
   {
       if(isNull())
        return rl;
       else
        return cdr().reverseRec(rl.cons(car()));
    }
    
   public String toString()
   {
      if ( empty ) 
      {
          return "()";
      } 
      else if ( rest.isNull() ) 
      {
          return "(" + first + ")";
      } 
      else 
      {
          String rep = "(" + first;
          StringSList r = rest;
          while ( !r.isNull() ) 
          {
            rep = rep + ", " + r.car();
            r = r.cdr();
          }
          return ( rep + ")" );
      }
   }
}

