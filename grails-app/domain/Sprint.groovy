class Sprint implements Comparable
{
   SortedSet stories
   static belongsTo = [project:Project]
   static hasMany = [stories:Story]
   String name
   String goal
   Integer number
   //String status

   static constraints = 
   {
      number(unique:'project')
      name(nullable: true)
      goal(nullable: true)
      //status(inList:["open", "done"]) 
   }

   /* this is for sorting things in the UI */
   static mapping = 
   {
      sort "number":"desc"
   }  


   String toString() 
   { 
      if(name)
      {
         return name + ' #' + number
      }
      return 'sprint #' + number
   }

   int compareTo(obj)
   {
      number.compareTo(obj.number) * (-1)
   }
}
