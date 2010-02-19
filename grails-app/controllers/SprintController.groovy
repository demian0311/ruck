class SprintController {
  def project
  def sprint
  def backlog

  def authenticateService

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

   def list = 
   {
      log.debug  'params: ' + params

      project = Project.get(params.id)

      def sprintsOut = [] 
      project.sprints.each
      {
         if(it.name != 'backlog')
         {
            sprintsOut.add(it)
         }
      }

      [sprintInstanceList: sprintsOut, projectInstance: project]
   }

   def plan = 
   {
      sprint = Sprint.get(params.id)
      project = sprint.project
      backlog = project.findBacklog()
   }

  /* this method re-orders stories in a sprint */
  def order =
  {
    sprint = Sprint.get(params.id)
    log.debug  'sprint: ' + sprint
    log.debug  'params: ' + params

    def currOrdinal = 0
    if (!params['sprintGroup[]']) {
      log.debug  'no stories found to order, returning now'
      render "no stories found to re-order, returning: " + params
      return
    }

	// set the ids to the new status
    def valuesToChange = []
    if (!params['sprintGroup[]'].toString().contains(","))
    {
        valuesToChange.add(params['sprintGroup[]'] as Integer)
    }
    else
    {
        valuesToChange = params['sprintGroup[]']
    }

    for (currentId in valuesToChange)
    {
//    for (currentId in params['sprintGroup[]']) {
      // persisted: [id:8, action:order, sprintGroup[]:66, controller:sprint]
      /*
      this code is going character by character.
      so it tries 6, then 6 again.

      if the data is 67 it'll try 6 and then story with id 7
      */

      log.debug  "currentId is ${currentId}"

      def story = Story.get(currentId)

      log.debug  "story is ${story}"

      story.ordinal = currOrdinal++
      sprint.addToStories(story)
      log.debug  'story id: ' + currentId
      log.debug  'attempting to add ' + story + " to " + sprint + " belonging to project " + sprint.project
    }

    log.debug  "persisted: " + params

    log.debug  'sprint stories --------------------------'
    for (currentStory in sprint.stories) {
      log.debug  '\t' + currentStory
    }

    render "persisted: " + params
  }

  def moveTask = {
    log.debug  '*****************************'
    log.debug '* MOVE TASK                 *'
    log.debug  '* params: ' + params
    log.debug  '*****************************'

    // need to find the ids
    for (currParam in params) {
      log.debug  'currParam: ' + currParam
      if (currParam.key.indexOf('Group_') != -1) {
        log.debug  '\tfound group ' + currParam

        // set the ids to the new status
        def valuesToChange = []
        if (!currParam.value.toString().contains(",")) {
          valuesToChange.add(currParam.value as Integer)
        } else {valuesToChange = currParam.value}

        for (currentId in valuesToChange) {
          log.debug  "\t\tchanging status of task with id of ${currentId} to ${params['newStatus']}"
          def currTask = Task.get(currentId)
          if (currTask) {
            currTask.status = params['newStatus']
            currTask.save()

            /* trying to save a note to say who changed the task status
             * this doesn't work, not sure why

            def userPrincipal = authenticateService.principal()
            def username = userPrincipal.getUsername()
            def contentString = "foo" //moved to status ${params['newStatus']} by ${username}"
            log.debug "***************** " + contentString
            def currTaskNote = new TaskNote(task:currTask, content: "foo")
            currTaskNote.save()
            */

          } else {
            log.debug  "\t\tcouldn't find a task with id: ${currentId}"
          }
        }
      }
    }

    render "recd: " + params
  }

  def show = {
    log.debug  '*****************************'
    log.debug  'params: ' + params
	if(params.id) {
    	sprint = Sprint.get(params.id)
    	log.debug  'sprint: ' + sprint
    	log.debug  'sprint.stories.isEmpty(): ' + sprint.stories.isEmpty()
	} else if (params.projectId){
		def project = Project.get(params.projectId)
		if(project) {
			def s = Sprint.findAllByClosedAndProject("false", project)
			if(s) {
				s.each{
					if(!it.name?.contains("backlog"))
						sprint = it
				}
			}
		}
	}

   if(params.status)
   {
      def outStr = sprint.toString() + "\n"
      
      sprint.stories.each
      { currStory ->
         if((currStory.status == params.status) || (params.status == "all"))
         {

            outStr += "\t($currStory.points) ${currStory.description}"

            if(params.status == "all")
            {
               outStr += " is in status ${currStory.status}\n"
            }
            else
            {
               outStr += "\n"
            }

            if(params.showTasks == '1')
            {
               currStory.tasks.each
               {
                  outStr += "\t\t${it}\n"
               }
            }
         }
      }

      render(text:outStr,contentType:"text",encoding:"UTF-8")
   }

    if (!sprint) {
      flash.message = "Sprint not found with id ${params.id}"
      redirect(action: list)
    }

    if (sprint.stories.isEmpty()) {
      redirect(action: plan, id: sprint.id)
    }
  }

  def close = {
    log.debug  '*****************************'
    log.debug  'params: ' + params
    sprint = Sprint.get(params.id)
    sprint.closed = true
    sprint.save(flush: true)

    project = sprint.project

    log.debug  'sprint: ' + sprint
    log.debug  'project: ' + project

    // find any stories that have tasks that are not completed
    def uncompletedStories = []
    for (currStory in sprint.stories) {
      log.debug  'checking story: ' + currStory
      def needToAddStory = false
      for (currTask in currStory.tasks) {
        log.debug  '\tchecking task: ' + currTask
        if (currTask.status != 'done') {
          needToAddStory = true
        }
      }

      if(currStory.tasks.size() == 0)
      {
         needToAddStory = true
      }

      if (needToAddStory) {
        uncompletedStories.add(currStory)
      }
    }

    log.debug  'uncompletedStories: ' + uncompletedStories

    def nextSprint = new Sprint()
    nextSprint.number = sprint.number + 1

    project.addToSprints(nextSprint)
    project.save(flush: true)

    def nextSprintResult
    for (currSprint in project.sprints) {
      log.debug  '\tcurrSprint: ' + currSprint
      log.debug  '\tcurrSprint.id: ' + currSprint.id
      if (currSprint.number == nextSprint.number) {
        nextSprintResult = currSprint
      }
    }
    log.debug  'the next sprint:     ' + nextSprintResult
    log.debug  'nextSprintResult.id: ' + nextSprintResult.id

    if (nextSprintResult.id == null) {
      log.debug  'the new sprint id is null'
    }

    // move the old stories over to the next sprint
    for (currUncompletedStory in uncompletedStories) {
      log.debug  'moving ' + currUncompletedStory + ' to next sprint'
      nextSprintResult.addToStories(currUncompletedStory)
    }
    nextSprintResult.save(flush: true)

    redirect(action: plan, id: nextSprintResult.id)
  }


  def edit = {
    def sprintInstance = Sprint.get(params.id)

    if (!sprintInstance) {
      flash.message = "Sprint not found with id ${params.id}"
      redirect(action: list)
    } else {
      return [sprintInstance: sprintInstance]
    }
  }

  def update = {
    def sprintInstance = Sprint.get(params.id)
    if (sprintInstance) {
      sprintInstance.properties = params
      if (!sprintInstance.hasErrors() && sprintInstance.save()) {
        flash.message = "Sprint ${params.id} updated"
        redirect(action: show, id: sprintInstance.id)
      } else {
        render(view: 'edit', model: [sprintInstance: sprintInstance])
      }
    } else {
      flash.message = "Sprint not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def sprintInstance = new Sprint()
    sprintInstance.properties = params
    return ['sprintInstance': sprintInstance]
  }

  def save = {
    def sprintInstance = new Sprint(params)
    if (!sprintInstance.hasErrors() && sprintInstance.save()) {
      flash.message = "Sprint ${sprintInstance.id} created"
      redirect(action: show, id: sprintInstance.id)
    } else {
      render(view: 'create', model: [sprintInstance: sprintInstance])
    }
  }
}
