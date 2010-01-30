class Sprint implements Comparable
{
   SortedSet stories
   static belongsTo = [project:Project]
   static hasMany = [stories:Story]
   String name
   String goal
   Integer number
   Boolean closed = false

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

   Story[] findTopStories(Integer numStories)
   {
      def topStories = []  
      int count = 0 
      for(currStory in stories)
      {
         if(count++ < numStories)
         {
            topStories.add(currStory)
         }
      }
      return topStories
   }

   Integer findStoryPoints()
   {
       def storyPoints = 0
       stories.each
       {
           storyPoints += it.points
       }
       storyPoints
   }

   Integer findCompletedStoryPoints()
   {
      def completedStoryPoints = 0
      for (story in stories)
      {
         if (story.getStatus() == "done")
         {
            completedStoryPoints += story.points
         }
      }
      return completedStoryPoints
   }

   String toString() 
   { 
      def outStr = ""

      if(name)
      {
         outStr += name + ' #' + number
      }
      else
      {
         outStr += 'Sprint #' + number
      }

      if(closed)
      {
         outStr += " (closed)"
      }

      // add the total points to the end of the sprint
      outStr += " - " + findCompletedStoryPoints() + " points finished."

      outStr
   }

   int compareTo(obj)
   {
      number.compareTo(obj.number) * (-1)
   }
}
