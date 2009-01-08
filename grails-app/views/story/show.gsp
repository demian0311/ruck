<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Story</title>
    </head>
    <body>

<div id="banner">
<a href="/ruck">ruck</a> | 
<g:link controller="project" action="show" id="${storyInstance.sprint.project.id}">${storyInstance.sprint.project.name}</g:link> | 
<g:link controller="sprint" action="show" id="${storyInstance.sprint.id}">${storyInstance.sprint.number}</g:link> | 
<g:link controller="story" action="show" id="${storyInstance.id}">${storyInstance.description}</g:link>
</div>

<div id="content">
<g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>

<g:each in="${storyInstance.tasks}" var="currTask">
   <li>${currTask}</li>
</g:each>

<g:if test="${storyInstance.tasks.isEmpty()}">
To accomplish this story, you probably have some tasks to do.
Add tasks and estimate the hours that it'll take to complete
that task.
<br/><br/>
If the story is trivial and you can't think of any tasks just
add one called 'doit'.
</g:if>


<g:form action="saveTask" method="post" >
(<input type="text" tabindex="1" size="1" id="hoursEstimate" name="hoursEstimate" 
      value="${fieldValue(bean:taskInstance,field:'hoursEstimate')}" />)
<input type="text" tabindex="2" size="75" id="name" name="name" 
      value="${fieldValue(bean:taskInstance,field:'name')}"/>
<input type="hidden" name="story.id" value="<%=storyInstance.id%>"/>
<input class="save" tabindex="3" type="submit" value="add" />
</g:form>

<br/><br/><hr/>
<g:link controller="sprint" action="show" id="${storyInstance.sprint.id}"><font size="-1">go back to the sprint</font></g:link>
</div>


</body></html>
