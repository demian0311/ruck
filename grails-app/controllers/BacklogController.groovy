class BacklogController 
{
    
   def index = { redirect(action:list,params:params) }
   Sprint backlog
   Project project
   Integer totalStoryPoints

   // the delete, save and update actions only accept POST requests
   static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

   def time = 
   {
      render "${new Date()}"
   }

   def changestorypoints = 
   {
      def story = Story.get(params.id)
      story.points = Integer.parseInt(params.value)
      story.save(flush: true)

      render "" + story.points 
   }

   def changestorydescription = 
   {
      def story = Story.get(params.id)
      story.description = params.value
      story.save(flush: true)

      render "" + story.description 
   }

   def deletestory = 
   {
      def story = Story.get(params.id)
      def backlogId = story.sprint.id
      story.delete()
      redirect(controller:'backlog',action:'list', id:backlogId)
   }

   def order = 
   {
      def backlog = Sprint.get(params.id)
      println 'backlog: ' + backlog

      def currOrdinal = 0
      for (currentId in params['backlogGroup[]'])
      {
         def story = Story.get(currentId)
         story.ordinal = currOrdinal++
         backlog.addToStories(story)
         println 'attempting to add ' + story + " to " + backlog
      }
      println "persisted: " + params 

      println 'backlog stories --------------------------'
      for(currentStory in backlog.stories)
      {
         println '\t' + currentStory
      }

      render "persisted: " + params 
   }


   def list = {
      if (project == null)
      {
         project = Project.get(params.id)
      }

      if(project)
      {
         backlog = Sprint.findWhere(project: project, number: 0)

         totalStoryPoints = 0
         for(currStory in backlog.stories)
         {
            totalStoryPoints += currStory.points
         }
      }
      else
      {
         flash.message = "select a project to see backlog"
         redirect(controller:'project',action:'list')
      }
    }

   def save = 
   { 
      println 'params: ' + params

      project = Project.get(params.projectId)
      println 'project: ' + project

      backlog = Sprint.findWhere(project: project, number: 0)
      println 'backlog: ' + backlog

      def storyInstance = new Story(params)
      storyInstance.sprint = backlog
      storyInstance.save(flush:true)

      redirect(controller:'backlog',action:'list', id:project.id)
   }

/*
    def show = {
        def storyInstance = Story.get( params.id )

        if(!storyInstance) {
            flash.message = "Story not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ storyInstance : storyInstance ] }
    }

    def delete = {
        def storyInstance = Story.get( params.id )
        if(storyInstance) {
            storyInstance.delete()
            flash.message = "Story ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "Story not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def storyInstance = Story.get( params.id )

        if(!storyInstance) {
            flash.message = "Story not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ storyInstance : storyInstance ]
        }
    }

    def update = {
        def storyInstance = Story.get( params.id )
        if(storyInstance) {
            storyInstance.properties = params
            if(!storyInstance.hasErrors() && storyInstance.save()) {
                flash.message = "Story ${params.id} updated"
                redirect(action:show,id:storyInstance.id)
            }
            else {
                render(view:'edit',model:[storyInstance:storyInstance])
            }
        }
        else {
            flash.message = "Story not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def storyInstance = new Story()
        storyInstance.properties = params
        return ['storyInstance':storyInstance]
    }
    */

}
