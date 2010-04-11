import java.math.RoundingMode
import java.math.MathContext

class ProjectController 
{
    
   def index = { redirect(action:list,params:params) }
   Sprint backlog
   Project project
   Integer totalBacklogStoryPoints = 0
   Integer displayDoneStoryPoints
   Integer displayBacklogStoryPoints

   def topStories 
   Integer moreStories
   private def STORIES_TO_SHOW_IN_BACKLOG = 5 

   def topSprints = []
   Integer moreSprints
   private def SPRINTS_TO_SHOW_IN_BACKLOG = 5

   String burndownChartData
   String velocityChartData

   Boolean showGraphs = true
   Boolean showSprints = true

   // the delete, save and update actions only accept POST requests
   static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

   def list = 
   {
      if(!params.max) params.max = 10
      [ projectInstanceList: Project.list( params ), personList: User.list(params) ]
   }

   def showText = 
   {
      project = Project.get(params.id)

      def outStr = project.toString() + "\n"
      outStr += "========================================================\n"

      project.sprints.each
      { currSprint ->
         outStr += "${currSprint}\n"

         if(params.level == 'story' || params.level == 'task')
         {
            currSprint.stories.each
            { currStory ->
               outStr += "\t${currStory} [${currStory.status}]\n"

               if(params.level == 'task')
               {
                  currStory.tasks.each
                  { currTask ->
                     outStr += "\t\t${currTask} [${currTask.status}]\n"
                  }
               }
            }
         }
      }

      render(text:outStr,contentType:"text",encoding:"UTF-8")
   }

   def show = 
   {
         project = Project.get(params.id)
         backlog = project.findBacklog() 
         totalBacklogStoryPoints = backlog.findStoryPoints()
         moreStories = backlog.stories.size() - STORIES_TO_SHOW_IN_BACKLOG 
         topStories = backlog.findTopStories(STORIES_TO_SHOW_IN_BACKLOG)

         if(backlog.findStoryPoints() == 0)
         {
            log.debug "there are no stories in the backlog so we won't display the sprints"
            log.debug "backlog.stories.size() : ${backlog.stories.size()}"
            log.debug "project.sprints.size() : ${project.sprints.size()}"

            // no story points, user needs to add stories to the
            // backlog first
            showSprints = false
         }

         if(project.sprints.size() <= 2)
         {
            // we don't really have enough information to care
            // about graphs yet
            showGraphs = false
            return
         }

         // got to take off an extra '1' for the backlog
         moreSprints = project.sprints.size() - SPRINTS_TO_SHOW_IN_BACKLOG - 1

         def sprintCount = 0
         project.sprints.each
         {
            sprintCount++
            if(sprintCount <= SPRINTS_TO_SHOW_IN_BACKLOG)
            {
               topSprints.add(it)
            }
         }

         burndownChartData = createBurndownChartData()
         velocityChartData = createVelocityChartData()
   }

   String createVelocityChartData()
   {
      def outData = "[" 

      int currSprintNum = project.sprints.size()
      project.sprints.each
      {
         outData += "[" + currSprintNum-- + ", " + it.findCompletedStoryPoints() + "],"
      }

      outData += "]"

      return outData
   }


   String createBurndownChartData()
   {
      int currStoryPoints = 0 

      def outData = "[" 
      int currSprintNum = project.sprints.size()

      project.sprints.each
      {
         outData += "[" + currSprintNum-- + ", " + currStoryPoints + "],"
         currStoryPoints += it.findCompletedStoryPoints()
      }

      outData += "]"

      return outData
    }

    def edit = 
    {
        def projectInstance = Project.get( params.id )

        if(!projectInstance) 
        {
            flash.message = "Project not found with id ${params.id}"
            redirect(action:list)
        }
        else 
        {
            return [ projectInstance : projectInstance ]
        }
    }

    def update = 
    {
        def projectInstance = Project.get( params.id )
        if(projectInstance) 
        {
            projectInstance.properties = params
            if(!projectInstance.hasErrors() && projectInstance.save()) 
            {
                flash.message = "Project ${params.id} updated"
                redirect(action:show,id:projectInstance.id)
            }
            else 
            {
                render(view:'edit',model:[projectInstance:projectInstance])
            }
        }
        else 
        {
            flash.message = "Project not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def save = 
    {
        def projectInstance = new Project(params)
        if(projectInstance.startDate == null)
        {
           projectInstance.startDate = new Date()
        }

        if(projectInstance.sprintLength == null)
        {
           projectInstance.sprintLength = 1 
        }

        if(!projectInstance.hasErrors() && projectInstance.save()) 
        {
            log.debug "project ${projectInstance.name} saved"

            def backlogSprint = new Sprint()
            backlogSprint.name = 'backlog'
            backlogSprint.goal = 'stories to here before being worked on'
            backlogSprint.number = 0
            projectInstance.addToSprints(backlogSprint)
            log.debug "backlog for project ${projectInstance.name} saved"

            def sprint1 = new Sprint()
            sprint1.number = 1

            if(sprint1.hasErrors())
            {
                log.debug "there were errors with the first sprint"
            }

            projectInstance.addToSprints(sprint1)
            log.debug "first sprint saved for project ${projectInstance.name} saved"

            projectInstance.save()

            flash.message = 
               "Project <i>${projectInstance}</i> created, click on " + 
               "<b>backlog</b> to add stories to the project"
            redirect(action:show,id:projectInstance.id)
        }
        else 
        {
            flash.message = "couldn't create project"
            redirect(action:list)
        }
    }
}
