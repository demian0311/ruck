class TaskNote 
{
   static belongsTo = [task:Task]
   String content
   Date createDate

   static constraints = 
   {
      content(blank:false)
      createDate()
   }

   String toString()
   {
      return content
   }

}
