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

   Sprint findBacklog()
   {
       return Sprint.findWhere(project: this, number: 0)
   }

   Integer findStoryPoints()
   {
      def storyPoints = 0
      for (sprint in sprints)
      {
         storyPoints += sprint.findStoryPoints()
      }
      return storyPoints
   }

   Integer findCompletedStoryPoints()
   {
      def completedStoryPoints = 0
      for (sprint in sprints)
      {
         completedStoryPoints += sprint.findCompletedStoryPoints()
      }
      return completedStoryPoints
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
