class Task implements Comparable
{
   static belongsTo = [story:Story]
   static hasMany = [notes:TaskNote]

   String name
   String status
   Integer hoursEstimate 
   Integer hoursActual

   static constraints = 
   {
      name(unique:'story')
      status(inList:["not started", "working", "verification", "done"])   
      hoursEstimate()
      hoursActual(nullable:true)
   }

   String toString() 
   { 
      if(hoursActual)
      {
         "(" + hoursActual + "/" + hoursEstimate + ") " +  name
      }
      "(" + hoursEstimate + ") " +  name
   }

   int compareTo(obj)
   {
      name.compareTo(obj.name)
   }
}
