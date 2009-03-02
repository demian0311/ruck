import java.math.RoundingMode
import java.math.MathContext

class ProjectController {
    
   def index = { redirect(action:list,params:params) }
   Sprint backlog
   Project project
   Integer totalBacklogStoryPoints
   def topStories 
   Integer totalStories
   Integer moreStories
   private def STORIES_TO_SHOW_IN_BACKLOG = 5 
   String velocityChartUrl
   String burndownChartUrl

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
         totalBacklogStoryPoints = 0
         topStories = [] 
         int count = 0
         for(currStory in backlog.stories)
         {
            totalBacklogStoryPoints += currStory.points
            if(count++ < STORIES_TO_SHOW_IN_BACKLOG)
            {
               topStories.add(currStory)
            }
         }

         //////////////////////////////////////////////////////////
         //////////////////////////////////////////////////////////
         // burndown chart url
         //////////////////////////////////////////////////////////
         //////////////////////////////////////////////////////////
         // make dots

         // create the url for the burndown chart
         burndownChartUrl = "cht=lc&"
         burndownChartUrl += "chxt=x,y&"
         burndownChartUrl += "chls=4,1,0&"
         burndownChartUrl += "chs=400x200&"
         burndownChartUrl += "chco=ddddee&"
         // chxl=0:|1|2|3|4|1:||50|350 
         
         // TODO: i must need to do the same math on the burndown that i 
         // had to do for the velocity chart

         // do labels
         def currSprintNumber = 0
         def labels = "chxl=0:|"
         (0..(project.sprints.size() - 2)).each
         {
            labels += currSprintNumber++ + "|"
         }
         burndownChartUrl += labels + "&"

         // do data
         // chd=s:9gounjqGJD&

         // figure out total story points in the entire project
         def totalStoryPoints = 0
         for(currSprint in project.sprints)
         {
            // not sure if this method is correct
            // it should get completed and uncompleted story points
            totalStoryPoints += currSprint.getStoryPoints()
         }
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
         for(currSprint in project.sprints)
         {
            if(firstSprint)
            {
               firstSprint = false
               // this is stupid
            }
            else
            {
               currPoints = currPoints - currSprint.getStoryPoints()
               def adjustedPoints = currPoints * burndownMultiplier 
               println ">>> ${currPoints} -> ${adjustedPoints}" 
               dataSet = dataSet + "," + (currPoints * burndownMultiplier)
            }
         }

         dataSet = dataSet[0..(dataSet.size() - 4)]
         println "dataSet: ${dataSet}"
         burndownChartUrl += "chd=t:"
         burndownChartUrl += dataSet + "&"

         // eastwood doesn't support this yet
         //burndownChartUrl += "chm=o,ff9900,0,${dataSet}&"

         def lastPositionBurndown = burndownChartUrl.size() - 3 
         burndownChartUrl = burndownChartUrl[0..lastPositionBurndown]


         //////////////////////////////////////////////////////////
         //////////////////////////////////////////////////////////
         // velocity chart
         //////////////////////////////////////////////////////////
         //////////////////////////////////////////////////////////

         // create the url for the velocity chart
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

         dataSet = "" // re-using a variable, so bad
         def sprintCount = project.sprints.size()
         project.sprints.each
         {
            def currVelocity = it.getCompletedStoryPoints()
            println "${it} - " + currVelocity 

            def adjustedVelocity = currVelocity * multiplier

            sprintCount--
            if(sprintCount > 0)
            {
               dataSet = adjustedVelocity + "," + dataSet 
            }
         }
         velocityChartUrl += dataSet
         def lastPosition = velocityChartUrl.size() - 2 

         velocityChartUrl = velocityChartUrl[0..lastPosition]
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
