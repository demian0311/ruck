class TaskNoteController 
{

   def index = { redirect(action:list,params:params) }

   // the delete, save and update actions only accept POST requests
   static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

   def list = 
   {
      if(!params.max) params.max = 10
      {
         [ taskNoteInstanceList: TaskNote.list( params ) ]
      }
   }

   def show = 
   {
      def taskNoteInstance = TaskNote.get( params.id )

      if(!taskNoteInstance) 
      {
         flash.message = "TaskNote not found with id ${params.id}"
         redirect(action:list)
      }
      else 
      { 
         return [ taskNoteInstance : taskNoteInstance ] 
      }
   }

   def delete = 
   {
      def taskNoteInstance = TaskNote.get( params.id )
      if(taskNoteInstance) 
      {
         taskNoteInstance.delete()
         flash.message = "TaskNote ${params.id} deleted"
         redirect(action:list)
      }
      else 
      {
         flash.message = "TaskNote not found with id ${params.id}"
         redirect(action:list)
      }
   }

   def edit = 
   {
      def taskNoteInstance = TaskNote.get( params.id )

      if(!taskNoteInstance) 
      {
         flash.message = "TaskNote not found with id ${params.id}"
         redirect(action:list)
      }
      else 
      {
         return [ taskNoteInstance : taskNoteInstance ]
      }
   }

   def update = 
   {
      def taskNoteInstance = TaskNote.get( params.id )
      if(taskNoteInstance) 
      {
         taskNoteInstance.properties = params
         if(!taskNoteInstance.hasErrors() && taskNoteInstance.save()) 
         {
            flash.message = "TaskNote ${params.id} updated"
            redirect(action:show,id:taskNoteInstance.id)
         }
         else 
         {
            render(view:'edit',model:[taskNoteInstance:taskNoteInstance])
         }
      }
      else 
      {
         flash.message = "TaskNote not found with id ${params.id}"
         redirect(action:edit,id:params.id)
      }
   }

   def create = 
   {
      def taskNoteInstance = new TaskNote()
      taskNoteInstance.properties = params
      return ['taskNoteInstance':taskNoteInstance]
   }

   def save = 
   {
      def taskNoteInstance = new TaskNote(params)
      if(!taskNoteInstance.hasErrors() && taskNoteInstance.save()) 
      {
         flash.message = "TaskNote ${taskNoteInstance.id} created"
         redirect(action:show,id:taskNoteInstance.id)
      }
      else 
      {
         render(view:'create',model:[taskNoteInstance:taskNoteInstance])
      }
   }
}
