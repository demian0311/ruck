import Project
import Sprint
import Story

class BacklogController
{
  def index = { redirect(action: list, params: params) }
  Sprint backlog
  Project project
  Integer totalStoryPoints
  Integer numStories

  // the delete, save and update actions only accept POST requests
  static def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def time = {
    render "${new Date()}"
  }

  def changestorypoints = {
    def story = Story.get(params.id)
    story.points = Integer.parseInt(params.value)
    story.save(flush: true)

    render "" + story.points
  }

  def changestorydescription = {
    def story = Story.get(params.id)
    story.description = params.value
    story.save(flush: true)

    render "" + story.description
  }

  def deletestory = {
    def story = Story.get(params.id)
    def backlogId = story.sprint.id
    story.delete()
    redirect(controller: 'backlog', action: 'list', id: backlogId)
  }

  def order = {
    def backlog = Sprint.get(params.id)
    println 'params: ' + params
    println 'backlog: ' + backlog

    def currOrdinal = 0
    if(! params['stories[]'])
    {
      println 'no stories found to order, returning now'
      render "no stories found to re-order, returning: " + params
      return
    }

    //for (currentId in params['stories[]'].split(',')) didn't work in backlog
    for (currentId in params['stories[]']) 
    {
      def story = Story.get(currentId)
      story.ordinal = currOrdinal
      backlog.addToStories(story)
      println 'attempting to add ' + story + " to " + backlog
    }

    println 'backlog stories --------------------------'
    for (currentStory in backlog.stories) 
    {
      println '\t' + currentStory
    }

    render "persisted: " + params
  }


  def list = {
     
    println "********************"
    println "PARAMS---- ${params}"
    println "********************"

    if (project == null) {
      Long projectId = new Long(params.id)
      project = Project.get(projectId)
      println "this is the project: $project"
    }

    if (project) {
      backlog = Sprint.findWhere(project: project, number: 0)

      // this should be a method on the project class
      totalStoryPoints = 0
      for (currStory in backlog.stories) {
        totalStoryPoints += currStory.points
      }
      println "total story points: $totalStoryPoints"

      numStories = backlog.stories.size()
    }
    else {
      flash.message = "select a project to see backlog"
      redirect(controller: 'project', action: 'list')
    }
    //return ['project':project]
  }

  def save = {
    println 'params: ' + params

    //project = Project.get(params.projectId)
    project = Project.get(params.id)
    println 'project: ' + project
   
    backlog = project.findBacklog()
    println 'backlog: ' + backlog

    def storyInstance = new Story(params)
    storyInstance.sprint = backlog
    if(!storyInstance.points)
    {
      storyInstance.points = 0
    }
    storyInstance.save(flush: true)

    println 'story after saving: ' + storyInstance

    redirect(controller: 'backlog', action: 'list', id: project.id)
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
