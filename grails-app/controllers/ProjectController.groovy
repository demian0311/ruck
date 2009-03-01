import java.math.RoundingMode
import java.math.MathContext

class ProjectController {
    
   def index = { redirect(action:list,params:params) }
   Sprint backlog
   Project project
   Integer totalStoryPoints
   def topStories 
   Integer totalStories
   Integer moreStories
   private def STORIES_TO_SHOW_IN_BACKLOG = 10
   String velocityChartUrl

    // the delete, save and update actions only accept POST requests
    static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ projectInstanceList: Project.list( params ) ]
    }

    def show = 
    {
         project = Project.get(params.id)
         backlog = Sprint.findWhere(project: project, number: 0)

         totalStories = backlog.stories.size()
         moreStories = totalStories - STORIES_TO_SHOW_IN_BACKLOG 
         totalStoryPoints = 0
         topStories = [] 
         int count = 0
         for(currStory in backlog.stories)
         {
            totalStoryPoints += currStory.points
            if(count++ < STORIES_TO_SHOW_IN_BACKLOG)
            {
               topStories.add(currStory)
            }
         }

         // do the math on the story points
         println '********************************************'
         for(currSprint in project.sprints)
         {
            println currSprint.number + ': ' + currSprint.getCompletedStoryPoints().toString()
         }

         // create the url for the velocity chart
         ////////////////////////////////////////
         // cht=bvg&
         // chs=400x200&
         // chxt=x,y&
         // chxl=0:|1|2|3|3|4|5|&
         // chco=ddddee&
         // chd=t:60,57,78,48,63&
         // chxr=1,10,33
         
         velocityChartUrl = "cht=bvg&"
         velocityChartUrl += "chs=400x200&"
         velocityChartUrl += "chxt=x,y&"
         velocityChartUrl += "chco=ddddee&"
         velocityChartUrl += "chxl=0:|"
         (1..(project.sprints.size() - 1)).each
         {
            velocityChartUrl += it + "|"
         }
         velocityChartUrl += "&"

         // find the max velocity
         def maxVelocity = 0
         for(currSprint in project.sprints)
         {
            def currVelocity = currSprint.getCompletedStoryPoints()
            if(currVelocity > maxVelocity)
            {
               maxVelocity = currVelocity
            }
         }
         def top = maxVelocity + 2
         //def multiplier = 100.divide(top, 0, RoundingMode.UP)
         def multiplier = (100.div(top)).round(new MathContext(1))

         velocityChartUrl += "chxr=1,0," + top + "&"
         velocityChartUrl += "chd=t:"
         // TODO: 
         // the problem is that we have it return sprints
         // in reverse order, so maybe we'll do a series
         // of prepending
         project.sprints.each
         {
            def currVelocity = it.getCompletedStoryPoints()
            println "${it} - " + currVelocity 

            def adjustedVelocity = currVelocity * multiplier
            velocityChartUrl += adjustedVelocity + "," 
         }
         def lastPosition = velocityChartUrl.size() - 2 

         velocityChartUrl = velocityChartUrl[0..lastPosition]
         println '**********************************************'
         println 'velocity chart url: ' + velocityChartUrl
    }

    def delete = {
        def projectInstance = Project.get( params.id )
        if(projectInstance) {
            projectInstance.delete()
            flash.message = "Project ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "Project not found with id ${params.id}"
            redirect(action:list)
        }
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

    def create = {
        def projectInstance = new Project()
        projectInstance.properties = params
        return ['projectInstance':projectInstance]
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
            // now create a default backlog 
            def backlogSprint = new Sprint()
            backlogSprint.name = 'backlog'
            backlogSprint.goal = 'stories to here before being worked on'
            backlogSprint.number = 0
            projectInstance.addToSprints(backlogSprint)

            def sprint1 = new Sprint()
            sprint1.number = 1 
            projectInstance.addToSprints(sprint1)

            projectInstance.save()

            flash.message = "Project <i>${projectInstance}</i> created, click on <b>manage backlog</b> to add stories to the project"
            redirect(action:show,id:projectInstance.id)
        }
        else {
            render(view:'create',model:[projectInstance:projectInstance])
        }
    }
}
