import Sprint
import Story
import Task

class SprintController
{
  def project
  def sprint
  def backlog
  
  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    if (!params.max) params.max = 10
    [sprintInstanceList: Sprint.list(params)]
  }

  def plan = {
    sprint = Sprint.get(params.id)
    project = sprint.project
    backlog = project.findBacklog()
  }

  def order = 
  {
    println 'params: ' + params
    def sprint = Sprint.get(params.id)
    println 'sprint: ' + sprint

    def currOrdinal = 0
    if(! params['sprintGroup[]'])
    {
       return
    }
    for (currentId in params['sprintGroup[]'].split(',')) 
    {
      // persisted: [id:8, action:order, sprintGroup[]:66, controller:sprint]
      /*
      this code is going character by character.
      so it tries 6, then 6 again.

      if the data is 67 it'll try 6 and then story with id 7
      */

      def story = Story.get(currentId)
      story.ordinal = currOrdinal++
      sprint.addToStories(story)
      println 'story id: ' + currentId
      println 'attempting to add ' + story + " to " + sprint + " belonging to project " + sprint.project
    }
    
    println "persisted: " + params

    println 'sprint stories --------------------------'
    for (currentStory in sprint.stories) 
    {
      println '\t' + currentStory
    }

    render "persisted: " + params
  }

  def moveTask = {
    println '*****************************'
    println '* MOVE TASK                 *'
    println '* params: ' + params
    println '*****************************'

    // need to find the ids
    for (currParam in params) {
      println 'currParam: ' + currParam
      if (currParam.key.indexOf('Group_') != -1) {
        println '\tfound group ' + currParam

        // set the ids to the new status
        for (currentId in currParam.value) {
          println "\t\tchanging status of task with id of ${currentId} to ${params['newStatus']}"
          def currTask = Task.get(currentId)
          if(currTask)
         {
            currTask.status = params['newStatus']
            currTask.save()
         }
         else
         {
            println "\t\tcouldn't find a task with id: ${currentId}"
         }
        }
      }
    }

    render "recd: " + params
  }

  def show = {
    println '*****************************'
    println 'params: ' + params
    sprint = Sprint.get(params.id)
    println 'sprint: ' + sprint
    println 'sprint.stories.isEmpty(): ' + sprint.stories.isEmpty()

    if (!sprint) {
      flash.message = "Sprint not found with id ${params.id}"
      redirect(action: list)
    }

    if (sprint.stories.isEmpty()) {
      redirect(action: plan, id: sprint.id)
    }
  }


  def close = {
    println '*****************************'
    println 'params: ' + params
    sprint = Sprint.get(params.id)
    sprint.closed = true
    sprint.save(flush: true)

    project = sprint.project

    println 'sprint: ' + sprint
    println 'project: ' + project

    // find any stories that have tasks that are not completed
    def uncompletedStories = []
    for (currStory in sprint.stories) {
      println 'checking story: ' + currStory
      def needToAddStory = false
      for (currTask in currStory.tasks) {
        println '\tchecking task: ' + currTask
        if (currTask.status != 'done') {
          needToAddStory = true
        }
      }

      if (needToAddStory) {
        uncompletedStories.add(currStory)
      }
    }

    println 'uncompletedStories: ' + uncompletedStories

    def nextSprint = new Sprint()
    nextSprint.number = sprint.number + 1

    project.addToSprints(nextSprint)
    project.save(flush: true)

    def nextSprintResult
    for (currSprint in project.sprints) {
      println '\tcurrSprint: ' + currSprint
      println '\tcurrSprint.id: ' + currSprint.id
      if (currSprint.number == nextSprint.number) {
        nextSprintResult = currSprint
      }
    }
    println 'the next sprint:     ' + nextSprintResult
    println 'nextSprintResult.id: ' + nextSprintResult.id

    if (nextSprintResult.id == null) {
      println 'the new sprint id is null'
    }

    // move the old stories over to the next sprint
    for (currUncompletedStory in uncompletedStories) {
      println 'moving ' + currUncompletedStory + ' to next sprint'
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
    }
    else {
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
      }
      else {
        render(view: 'edit', model: [sprintInstance: sprintInstance])
      }
    }
    else {
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
    }
    else {
      render(view: 'create', model: [sprintInstance: sprintInstance])
    }
  }
}
