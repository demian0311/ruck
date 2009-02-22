<html>
<head>
  <meta name="layout" content="main"/>
  <title>Show Story</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <g:link controller="project" action="show" id="${storyInstance.sprint.project.id}">${storyInstance.sprint.project.name}</g:link> |
  <g:link controller="sprint" action="show" id="${storyInstance.sprint.id}">${storyInstance.sprint.number}</g:link> |
  <g:link controller="story" action="show" id="${storyInstance.id}">${storyInstance.description}</g:link>
</div></div>
<hr class="ruck-space"/>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<g:if test="${!storyInstance.tasks.isEmpty()}">
  <div class="ruck-span-24">
    <fieldset>
      <legend>Current Tasks</legend>
      <ul class="story" id="stories">
        <g:each in="${storyInstance.tasks}" var="currTask">
          <li class="story" onmouseout="$('del_${currTask.id}').hide();" onmouseover="$('del_${currTask.id}').show();">${currTask}
            <span id="del_${currTask.id}" style="display: none">
              <g:link controller="story" action="deleteTask" id="${currTask.id}">delete</g:link>
            </span>
          </li>
        </g:each>
      </ul>
    </fieldset>
  </div>
</g:if>

<g:else>
  <div class="ruck-span-24">
    <fieldset>
      <h6>To accomplish this story, you probably have some tasks to do</h6>
      <hr/>
      <p>Add tasks and estimate the hours that it'll take to complete that task.
      If the story is trivial and you can't think of any tasks just add one called 'doit'.</p>
    </fieldset>
  </div>
</g:else>

<hr class="ruck-space"/>
<g:form action="saveTask" method="post">
  <fieldset>
    <legend>Add a New Task</legend>
    <p>
      <label for="hoursEstimate">Hours estimate</label><br/>
      <input type="text" tabindex="1" size="1" id="hoursEstimate" name="hoursEstimate" class="ruck-text" value="${fieldValue(bean: taskInstance, field: 'hoursEstimate')}"/>
    </p>
    <p>
      <label for="name">Task name</label><br/>
      <input type="text" tabindex="2" size="75" id="name" name="name" class="ruck-text" value="${fieldValue(bean: taskInstance, field: 'name')}"/>
    </p>
    <input type="hidden" name="story.id" value="<%=storyInstance.id%>"/>
    <hr/>
    <button type="submit" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt=""/>add</button>
  </fieldset>
</g:form>

</body></html>
