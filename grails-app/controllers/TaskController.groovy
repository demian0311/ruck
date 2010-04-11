class TaskController 
{

   def index = { redirect(action: list, params: params) }

   // the delete, save and update actions only accept POST requests
   static def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

   def list = 
   {
      if (!params.max) params.max = 10
      [taskInstanceList: Task.list(params)]
   }

   def show = 
   {
      def taskInstance = Task.get(params.id)

      if (!taskInstance) 
      {
         flash.message = "Task not found with id ${params.id}"
         redirect(action: list)
      } 
      else 
      { 
         return [taskInstance: taskInstance] 
      }
   }

   def delete = 
   {
      def taskInstance = Task.get(params.id)
      if (taskInstance) 
      {
         taskInstance.delete()
         flash.message = "Task ${params.id} deleted"
         redirect(action: list)
      } 
      else 
      {
         flash.message = "Task not found with id ${params.id}"
         redirect(action: list)
      }
   }

   def edit = 
   {
      def taskInstance = Task.get(params.id)

      if (!taskInstance) 
      {
         flash.message = "Task not found with id ${params.id}"
         redirect(action: list)
      } 
      else 
      {
         return [taskInstance: taskInstance]
      }
   }

   def update = 
   {
      def taskInstance = Task.get(params.id)
      if (taskInstance) 
      {
         taskInstance.properties = params
         if (!taskInstance.hasErrors() && taskInstance.save()) 
         {
            flash.message = "Task ${params.id} updated"
            redirect(action: show, id: taskInstance.id)
         } 
         else 
         {
            render(view: 'edit', model: [taskInstance: taskInstance])
         }
      } 
      else 
      {
         flash.message = "Task not found with id ${params.id}"
         redirect(action: edit, id: params.id)
      }
   }

   def create = 
   {
      def taskInstance = new Task()
      taskInstance.properties = params
      return ['taskInstance': taskInstance]
   }

   def save = 
   {
      def taskInstance = new Task(params)
      if (!taskInstance.hasErrors() && taskInstance.save()) 
      {
         flash.message = "Task ${taskInstance.id} created"
         redirect(action: show, id: taskInstance.id)
      } 
      else 
      {
         render(view: 'create', model: [taskInstance: taskInstance])
      }
   }
}
