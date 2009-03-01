class Sprint implements Comparable
{
   SortedSet stories
   static belongsTo = [project:Project]
   static hasMany = [stories:Story]
   String name
   String goal
   Integer number
   Boolean closed = false
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

/*
   Integer getStoryPoints()
   {
      def storyPoints = 0
      for (story in stories)
      {
         storyPoints += story.points
      }
      return storyPoints
   }

   void setStoryPoints(Integer pointsIn)
   {
      // why do i need this?
   }
   */

   Integer getCompletedStoryPoints()
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

   void setCompletedStoryPoints(Integer pointsIn)
   {
      // why do i need this? 
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
         outStr += 'sprint #' + number
      }

      if(closed)
      {
         outStr += " (closed)"
      }

      outStr += " " + getCompletedStoryPoints() + " completed points"

      return outStr
   }

   int compareTo(obj)
   {
      number.compareTo(obj.number) * (-1)
   }
}
