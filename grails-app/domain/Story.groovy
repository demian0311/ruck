class Story implements Comparable
{
   SortedSet tasks
   static belongsTo = [sprint:Sprint]
   static hasMany = [tasks:Task]
   Integer ordinal
   String description
   Integer points = 0

   static constraints =  {
      points(nullable:true)
      description(blank:false, unique:'sprint')
      ordinal()
   }

   /**
    * the status for the story corresponds to the lowest status of
    * any of the tasks.
    */
   String getStatus()
   {
      def statuses = ["not started", "working", "verification", "done"]
      for (status in statuses)
      {
         for (task in tasks)
         {
            if(task.status == status)
            {
               return status;
            }
         }
      }

      // maybe we have no tasks
      "not started"
   }

   void setStatus(String statusIn)
   {
      // why do i need this?
   }

   String toString() 
   {
      //return "(" + points + ") " + description + " - " + getStatus()
      "(" + points + ") " + description
   }

   int compareTo(obj) {
      ordinal.compareTo(obj.ordinal)
   }
}
