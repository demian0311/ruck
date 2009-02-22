class Story implements Comparable
{
   static belongsTo = [sprint:Sprint]
   static hasMany = [tasks:Task]
   Integer ordinal
   String description
   Integer points

   static constraints =  {
      points(nullable:true)
      description(blank:false, unique:'sprint')
      ordinal()
   }

   String toString() {
      return "(" + points + ") " + description
   }

   int compareTo(obj) {
      ordinal.compareTo(obj.ordinal)
   }
}

