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
    log.debug "Changing story to " + params
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
    backlog = Sprint.get(params.id)
    log.debug  'params: ' + params
    log.debug  'backlog: ' + backlog

    def currOrdinal = 0
    if (!params['stories[]']) {
      log.debug  'no stories found to order, returning now'
      render "no stories found to re-order, returning: " + params
      return
    }
    
    // set the ids to the new status
    def valuesToChange = []
    if (!params['stories[]'].toString().contains(","))
    {
        valuesToChange.add(params['stories[]'] as Integer)
    }
    else
    {
        valuesToChange = params['stories[]']
    }

    for (currentId in valuesToChange)
    {
      log.debug  "ordering story id: ${currentId}"

      def story = Story.get(currentId)
      log.debug "story found ${story}"
      story.ordinal = ++currOrdinal
      // here is where we should be setting it to the backlog

      story.sprint = backlog // if we're ordering it in the backlog it must belong
      story.save(flush: true)

      log.debug  '\tattempting to add ' + story + " to " + backlog
    }

    //backlog.cleanStoryOrdinals()

    log.debug  'backlog stories --------------------------'
    for (currentStory in backlog.stories) {
      log.debug  '\t' + currentStory
    }

    render "persisted: " + params
  }


  def list = {

    log.debug  "********************"
    log.debug  "PARAMS---- ${params}"
    log.debug  "********************"

    if (project == null) {
      Long projectId = new Long(params.id)
      project = Project.get(projectId)
      log.debug  "this is the project: $project"
    }

    if (project) {
      backlog = Sprint.findWhere(project: project, number: 0)

      // this should be a method on the project class
      totalStoryPoints = 0
      for (currStory in backlog.stories) {
        totalStoryPoints += currStory.points
      }
      log.debug  "total story points: $totalStoryPoints"

      numStories = backlog.stories.size()
    } 
    else
    {
      flash.message = "select a project to see backlog"
      redirect(controller: 'project', action: 'list')
    }
  }

  def save = 
  {
      log.debug  'params: ' + params
      project = Project.get(params.id)
      log.debug  'project: ' + project
    
      backlog = project.findBacklog()
      log.debug  'backlog: ' + backlog

      def storyInstance = new Story(params)
	   while(Story.findByOrdinal(storyInstance.ordinal)) 
      {
         storyInstance.ordinal = storyInstance.ordinal + 1
      }
      Sprint backlog = Sprint.findWhere(project: project, number: 0)
      backlog.addToStories(storyInstance)

      if(!storyInstance.save(flush: true))
      {
         log.debug("was unable to save story...")
         storyInstance.errors.each
         {
            log.debug(it)
         }
      }
      log.debug  'story after saving: ' + storyInstance

      redirect(controller: 'backlog', action: 'list', id: project.id)
  }
}
