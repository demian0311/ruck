<html>
<head>
  <meta name="layout" content="main"/>
  <title>Show Story</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo; 
  <g:link controller="project" action="show" id="${storyInstance.sprint.project.id}">${storyInstance.sprint.project.name}</g:link>
  &raquo; 
  <g:link controller="sprint" action="show" id="${storyInstance.sprint.id}">sprint #${storyInstance.sprint.number}</g:link>
</div>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>
<h1><i>
   <span id="storydescription">${storyInstance.description}</span>
</i></h1>

  <div class="ruck-span-24">
    <fieldset>
      <legend>tasks needed to finish story</legend>
      <ul class="story" id="stories">
        <g:each in="${storyInstance.tasks}" var="currTask">
          <li class="story" onmouseout="$('del_${currTask.id}').hide();" onmouseover="$('del_${currTask.id}').show();">${currTask}
            <span id="del_${currTask.id}" style="display: none">
              <g:link controller="story" action="deleteTask" id="${currTask.id}">delete</g:link>
            </span>
          </li>
        </g:each>
      </ul>

<g:form action="saveTask" method="post">
   <input type="text" tabindex="1" size="1" id="hoursEstimate" name="hoursEstimate" class="ruck-text" value="${fieldValue(bean: taskInstance, field: 'hoursEstimate')}"/>
   <input type="text" tabindex="2" size="75" id="name" name="name" class="ruck-text" value="${fieldValue(bean: taskInstance, field: 'name')}"/>
    <input type="hidden" name="story.id" value="<%=storyInstance.id%>"/>
    <button type="submit" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt=""/>add</button>
</g:form>

   <g:if test="${storyInstance.tasks.isEmpty()}">
      <h6>To accomplish this story, you probably have some tasks to do</h6>
      <p>Add tasks and estimate the hours that it'll take to complete that task.
      If the story is trivial and you can't think of any tasks just add one called 'doit'.</p>
  </g:if>

    </fieldset>
  </div>

<% //javascript placed below main content %>
<script type="text/javascript">
Event.observe(window, 'load', function() 
{
   new Ajax.InPlaceEditor('storydescription','/ruck/backlog/changestorydescription/${storyInstance.id}', 
   {
      cols: 75,
      okControl: true,
      cancelControl: true
   }); 

}); 
</script>

</body></html>
