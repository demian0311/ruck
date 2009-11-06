import java.math.RoundingMode
import java.math.MathContext

class ProjectController {
    
   def index = { redirect(action:list,params:params) }
   Sprint backlog
   Project project
   Integer totalBacklogStoryPoints = 0
   def topStories 
   Integer displayDoneStoryPoints
   Integer displayBacklogStoryPoints

   Integer moreStories
   private def STORIES_TO_SHOW_IN_BACKLOG = 5 
   String velocityChartUrl
   String burndownChartUrl

   Boolean showGraphs = true
   Boolean showSprints = true

   // the delete, save and update actions only accept POST requests
   static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

   def list = 
   {
      if(!params.max) params.max = 10
      [ projectInstanceList: Project.list( params ) ]
   }

   def show = 
   {
         project = Project.get(params.id)
         backlog = project.findBacklog() 
         totalBacklogStoryPoints = backlog.findStoryPoints()
         moreStories = backlog.stories.size() - STORIES_TO_SHOW_IN_BACKLOG 
         topStories = backlog.findTopStories(STORIES_TO_SHOW_IN_BACKLOG)

         //if(project.findStoryPoints() == 0)
         //if(backlog.stories.size() == 0 || project.sprints.size() >= 2)
         if(backlog.findStoryPoints() == 0)
         {
            println "there are no stories in the backlog so we won't display the sprints"
            println "backlog.stories.size() : ${backlog.stories.size()}"
            println "project.sprints.size() : ${project.sprints.size()}"
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

         burndownChartUrl = createBurndownChartUrl()
         velocityChartUrl = createVelocityChartUrl()
   }

   String createBurndownChartUrl()
   {
         // create the url for the burndown chart
         def burndownChartUrl = "cht=lc&"
         burndownChartUrl += "chxt=x,y&"
         burndownChartUrl += "chls=4,1,0&"
         burndownChartUrl += "chs=400x200&"
         burndownChartUrl += "chco=ddddee&"

         // do labels
         def currSprintNumber = 0
         def labels = "chxl=0:|"
         (0..(project.sprints.size() - 2)).each
         {
            labels += currSprintNumber++ + "|"
         }
         burndownChartUrl += labels + "&"

         // figure out total story points in the entire project
         def totalStoryPoints = project.findStoryPoints()

         println "total story points: ${totalStoryPoints}"
         
         // velocityChartUrl += "chxr=1,0," + top + "&"
         def burndownTop = totalStoryPoints + 10 
         burndownChartUrl += "chxr=1,0," + burndownTop + "&" 
         def burndownMultiplier = (100.div(burndownTop)).round(new MathContext(1))

         // now create data points by decrementing the total points
         def dataSet = "${totalStoryPoints * burndownMultiplier}"
         def currPoints = totalStoryPoints

         // got to make sure this doesn't include the backlog and
         // the current sprint that has points in it but the points
         // are not done
         def firstSprint = true
         totalStoryPoints = 0

         //(currSprint in project.sprints)
         project.sprints.each
         {
            if(firstSprint)
            {
               firstSprint = false
            }
            else
            {
               currPoints = currPoints - it.findStoryPoints()
               totalStoryPoints += currPoints
               //def adjustedPoints = currPoints * burndownMultiplier 
               dataSet = dataSet + "," + (currPoints * burndownMultiplier)
            }
         }

         println "dataSet: ${dataSet}"
         burndownChartUrl += "chd=t:${dataSet}"
         return burndownChartUrl
   }

   String createVelocityChartUrl()
   {
      // create the url for the velocity chart
      def velocityChartUrl = "cht=bvg&"
      velocityChartUrl += "chs=400x200&"
      velocityChartUrl += "chxt=x,y&"
      velocityChartUrl += "chco=ddddee&"
      velocityChartUrl += "chxl=0:|"
      (1..(project.sprints.size() - 1)).each
      {
            velocityChartUrl += it + "|"
      }
      velocityChartUrl += "&"

      def top = project.findMaxVelocity() + 2
      println "top >> ${top}"

      def multiplier = (100.div(top)).round(new MathContext(0))
      println "multiplier >> ${multiplier}"

      velocityChartUrl += "chxr=1,0," + top + "&"
      velocityChartUrl += "chd=t:"

      def dataSet = "" 
      def sprintCount = project.sprints.size()
      def firstSprint = true
      project.sprints.each
      {
         if(it.number != 0)
         {
            println "]]] it: ${it}"
            def currVelocity = it.findCompletedStoryPoints()
            println "]]] currVelocity:       ${currVelocity}"
            println "]]] multiplier:         ${multiplier}"
            def adjustedVelocity = currVelocity * multiplier

            println "\t]]] adjustedVelocity: ${adjustedVelocity}"
            dataSet = adjustedVelocity + "," + dataSet 
         }
      }
      velocityChartUrl += dataSet[0..(dataSet.size()-2)]

      println "velocityChartUrl: ${velocityChartUrl}"
      return velocityChartUrl
    }

    def edit = 
    {
        def projectInstance = Project.get( params.id )

        if(!projectInstance) {
            flash.message = "Project not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ projectInstance : projectInstance ]
        }
    }

    def update = {
        def projectInstance = Project.get( params.id )
        if(projectInstance) {
            projectInstance.properties = params
            if(!projectInstance.hasErrors() && projectInstance.save()) {
                flash.message = "Project ${params.id} updated"
                redirect(action:show,id:projectInstance.id)
            }
            else {
                render(view:'edit',model:[projectInstance:projectInstance])
            }
        }
        else {
            flash.message = "Project not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }


    def save = {
        def projectInstance = new Project(params)
        if(projectInstance.startDate == null)
        {
           projectInstance.startDate = new Date()
        }

        if(projectInstance.sprintLength == null)
        {
           projectInstance.sprintLength = 1 
        }

        if(!projectInstance.hasErrors() && projectInstance.save()) {
            println "project ${projectInstance.name} saved"

            def backlogSprint = new Sprint()
            backlogSprint.name = 'backlog'
            backlogSprint.goal = 'stories to here before being worked on'
            backlogSprint.number = 0
            projectInstance.addToSprints(backlogSprint)
            println "backlog for project ${projectInstance.name} saved"

            def sprint1 = new Sprint()
            sprint1.number = 1

            if(sprint1.hasErrors())
            {
                println "there were errors with the first sprint"
            }

            projectInstance.addToSprints(sprint1)
            println "first sprint saved for project ${projectInstance.name} saved"

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
