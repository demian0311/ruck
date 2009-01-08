<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>show sprint</title>
    </head>
    <body>

<script type="text/javascript">
postUrl = '/ruck/sprint/moveTask/${sprint.id}'; // this is the ID of the story

<g:each var="currStory" in="${sprint.stories}">
// update methods for ${currStory}
//
<g:if test="${!currStory.tasks.isEmpty()}"><!-- there are no stories -->

function updateNotStartedGroup_${currStory.id}()
{
   var params = Sortable.serialize('notStartedGroup_${currStory.id}')
   params += '&newStatus=not started'

   var options = 
   { 
      method : 'post', 
      parameters : params 
   };
   new Ajax.Request(postUrl, options);
}

function updateWorkingGroup_${currStory.id}()
{
   var params = Sortable.serialize('workingGroup_${currStory.id}');
   params += '&newStatus=working'

   var options = 
   { 
      method : 'post', 
      parameters : params 
   };
   new Ajax.Request(postUrl, options);
}

function updateVerificationGroup_${currStory.id}()
{
   var params = Sortable.serialize('verificationGroup_${currStory.id}');
   params += '&newStatus=verification'

   var options = 
   { 
      method : 'post', 
      parameters : params 
   };
   new Ajax.Request(postUrl, options);
}

function updateDoneGroup_${currStory.id}()
{
   var params = Sortable.serialize('doneGroup_${currStory.id}');
   params += '&newStatus=done'

   var options = 
   { 
      method : 'post', 
      parameters : params 
   };
   new Ajax.Request(postUrl, options);
}
</g:if><!-- there are no stories -->
</g:each>

window.onload = function()
{
   <g:each var="currStory" in="${sprint.stories}">
   <g:if test="${!currStory.tasks.isEmpty()}"><!-- there are no stories -->
   groups = [ 'notStartedGroup_${currStory.id}','workingGroup_${currStory.id}','verificationGroup_${currStory.id}', 'doneGroup_${currStory.id}']
   Sortable.create
   (
      'notStartedGroup_${currStory.id}', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate: updateNotStartedGroup_${currStory.id}
      }
   );

   Sortable.create
   (
      'workingGroup_${currStory.id}', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate: updateWorkingGroup_${currStory.id}
      }
   );

   Sortable.create
   (
      'verificationGroup_${currStory.id}', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate: updateVerificationGroup_${currStory.id}
      }
   );

   Sortable.create
   (
      'doneGroup_${currStory.id}', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate: updateDoneGroup_${currStory.id}
      }
   );
   </g:if><!-- there are no stories -->
   </g:each>
}
</script>

<div id="banner">
<a href="/ruck">ruck</a> | 
<g:link controller="project" action="show" id="${sprint.project.id}">${sprint.project.name}</g:link> | 
<g:link controller="sprint" action="show" id="${sprint.id}">${sprint}</g:link>
</div>

<div id="content">
<g:if test="${flash.message}">
<div class="message">${flash.message}</div>
</g:if>
<br/>
<table class="task" width="90%">
<tr>
   <th width="30%">story</th>
   <th width="15%">not started</th>
   <th width="15%">working</th>
   <th width="15%">verification</th>
   <th width="15%">done</th>
</tr>
<g:each var="currStory" in="${sprint.stories}" status="count">
   <tr>
      <td class="taskBoard" valign="top">
         <g:link controller="story" action="show" id="${currStory.id}">${currStory.description}</g:link>
      </td>

      <g:if test="${currStory.tasks.isEmpty()}">
      <td colspan="4" class="taskBoard" valign="top">click on the story to add tasks</td>
      </g:if><!-- there are no tasks -->

      <g:if test="${!currStory.tasks.isEmpty()}">
      <td class="taskBoard" valign="top">
            <font size="-2">
            <ul id="notStartedGroup_${currStory.id}" class="dragGroup">
            <g:each var="currTask" in="${currStory.tasks}">
               <g:if test="${currTask.status == 'not started'}">
                  <li id="task_${currTask.id}" class="dragItem">${currTask}</li>
               </g:if>
            </g:each>
            </ul>
            </font>
      </td>

      <td class="taskBoard" valign="top">
            <font size="-2">
            <ul id="workingGroup_${currStory.id}" class="dragGroup">
            <g:each var="currTask" in="${currStory.tasks}">
               <g:if test="${currTask.status == 'working'}">
                  <li id="task_${currTask.id}" class="dragItem">${currTask}</li>
               </g:if>
            </g:each>
            </ul>
            </font>
      </td>

      <td class="taskBoard" valign="top">
            <font size="-2">
            <ul id="verificationGroup_${currStory.id}" class="dragGroup">
            <g:each var="currTask" in="${currStory.tasks}">
               <g:if test="${currTask.status == 'verification'}">
                  <li id="task_${currTask.id}" class="dragItem">${currTask}</li>
               </g:if>
            </g:each>
            </ul>
            </font>
      </td>

      <td class="taskBoard" valign="top">
            <font size="-2">
            <ul id="doneGroup_${currStory.id}" class="dragGroup">
            <g:each var="currTask" in="${currStory.tasks}">
               <g:if test="${currTask.status == 'done'}">
                  <li id="task_${currTask.id}" class="dragItem">${currTask}</li>
               </g:if>
            </g:each>
            </ul>
            </font>
      </td>

      </g:if><!-- there are tasks -->

   </tr>
</g:each>
</table>

<br/> <br/>
<hr/>
<g:link controller="sprint" action="plan" id="${sprint.id}">add stories from backlog</g:link>
<br/>
<g:link controller="sprint" action="close" id="${sprint.id}">close this sprint</g:link>

</div><!-- content -->
</body>
</html>
