import grails.converters.JSON

class BacklogController {
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
    story.points = Integer.parseInt(params?.value)
    story.save(flush: true)

    render "" + story.points
  }

  def changestorydescription = {
    def story = Story.get(params.id)
    story.description = params.value
    story.save(flush: true)

    render "" + story.description
  }

  def changestory = {
    println "Changing story to " + params
    def story = Story.get(params.id)
    story.description = params.description
    story.points = Integer.parseInt(params?.points)
    story.save(flush: true)
    render story as JSON
  }

  def deletestory = {
    def story = Story.get(params.id)
    def backlogId = story.sprint.id
    story.delete()
    redirect(controller: 'backlog', action: 'list', id: backlogId)
  }

  /* this method changes the ordering of the stories in the backlog */
  def order =
  {
    // do some checking here to make sure that the story is owned by the
    // same sprint we think it should be associated with

    backlog = Sprint.get(params.id)
    println 'params: ' + params
    println 'backlog: ' + backlog

    def currOrdinal = 0
    if (!params['stories[]']) {
      println 'no stories found to order, returning now'
      render "no stories found to re-order, returning: " + params
      return
    }

    println 'fixing order of stories now---'
    for (currentId in params['stories[]']) {
      println "ordering story id: ${currentId}"

      def story = Story.get(currentId)
      println "story found ${story}"

      story.ordinal = ++currOrdinal

      // new
      //story.save()

      println '\tattempting to add ' + story + " to " + backlog
    }

    println 'backlog stories --------------------------'
    for (currentStory in backlog.stories) {
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
    else
    {
      flash.message = "select a project to see backlog"
      redirect(controller: 'project', action: 'list')
    }
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
    println storyInstance
    if (!storyInstance.points) {
      storyInstance.points = 0
    }
    storyInstance.save(flush: true)

    println 'story after saving: ' + storyInstance

    redirect(controller: 'backlog', action: 'list', id: project.id)
  }

}
