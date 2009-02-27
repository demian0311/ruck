class Project {
   SortedSet sprints
   static hasMany = [sprints:Sprint]
   String name
   String description
   Date startDate
   Integer sprintLength

   static constraints = 
   {
      name(unique:true)
      description(nullable:true)
      sprintLength()
      startDate()
   }

   String toString() 
   { 
      if(description)
      {
         return name + " - " + description
      }
      return name
   }
}
