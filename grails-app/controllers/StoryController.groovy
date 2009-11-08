class StoryController {

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    if (!params.max) params.max = 10
    [storyInstanceList: Story.list(params)]
  }

  def show = {
    def storyInstance = Story.get(params.id)

    if (!storyInstance) {
      flash.message = "Story not found with id ${params.id}"
      redirect(action: list)
    } else { return [storyInstance: storyInstance] }
  }

  def deleteTask = {
    // get code from task controller for deletion
    def taskInstance = Task.get(params.id)
    Story story = taskInstance.story
    taskInstance.delete()

    params.id = story.id

    redirect(controller: 'story', action: 'show', id: story.id)
  }

  def delete = {
    def storyInstance = Story.get(params.id)
    if (storyInstance) {
      storyInstance.delete()
      flash.message = "Story ${params.id} deleted"
      redirect(action: list)
    } else {
      flash.message = "Story not found with id ${params.id}"
      redirect(action: list)
    }
  }

  def edit = {
    def storyInstance = Story.get(params.id)

    if (!storyInstance) {
      flash.message = "Story not found with id ${params.id}"
      redirect(action: list)
    } else {
      return [storyInstance: storyInstance]
    }
  }

  def update = {
    def storyInstance = Story.get(params.id)
    if (storyInstance) {
      storyInstance.properties = params
      if (!storyInstance.hasErrors() && storyInstance.save()) {
        flash.message = "Story ${params.id} updated"
        redirect(action: show, id: storyInstance.id)
      } else {
        render(view: 'edit', model: [storyInstance: storyInstance])
      }
    } else {
      flash.message = "Story not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def storyInstance = new Story()
    storyInstance.properties = params
    return ['storyInstance': storyInstance]
  }

  def storyInstance

  def saveTask =
  {
    log.debug '**********************************************'
    log.debug 'params: ' + params
    log.debug '**********************************************'
    storyInstance = Story.get(params.story.id)

    def task = new Task(params)
    task.status = 'not started'
    if (!task.hasErrors() && task.save()) {
      log.debug 'should have saved'
      redirect(controller: 'story', action: 'show', id: params.story.id)
    } else {
      log.debug 'there were errors'
      redirect(controller: 'story', action: 'show', id: params.story.id)
    }
  }

  def save = {
    def storyInstance = new Story(params)
    if (!storyInstance.hasErrors() && storyInstance.save()) {
      flash.message = "Story ${storyInstance.id} created"
      redirect(action: show, id: storyInstance.id)
    } else {
      render(view: 'create', model: [storyInstance: storyInstance])
    }
  }
}
