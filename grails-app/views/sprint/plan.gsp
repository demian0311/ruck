<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main" />
<title>sprint plan</title>
</head>
<body>

<div id="banner">
<a href="/ruck">ruck</a> | 
<g:link controller="project" action="show" id="${sprint.project.id}">${sprint.project.name}</g:link> | 
<g:link controller="sprint" action="show" id="${sprint.id}">${sprint}</g:link> | 
<a href="">plan</a></div>

<div id="content">


<script type="text/javascript">
function updateBacklogPlan()
{
   var options = 
   {
      method : 'post',
      parameters : Sortable.serialize('backlogGroup')
   };
   new Ajax.Request('/ruck/backlog/order/${backlog.id}', options);
}

function updateSprintPlan()
{
   var options = 
   {
      method : 'post',
      parameters : Sortable.serialize('sprintGroup')
   };
   new Ajax.Request('/ruck/sprint/order/${sprint.id}', options);
}

window.onload = function()
{
   groups = [ 'backlogGroup','sprintGroup' ]
   Sortable.create
   (
      'backlogGroup', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate:updateBacklogPlan
      }
   );

   Sortable.create
   (
      'sprintGroup', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         dropOnEmpty: true, 
         containment: groups,
         constraint: false,
         onUpdate:updateSprintPlan
      }
   );
}
</script>

<table><tr><td valign='top'>
<div align="center">${backlog}</div>
<ul>
   <div id="backlogGroup" class="group">
   <g:each var="currStory" in="${backlog.stories}">
      <li id="story_${currStory.id}">${currStory}</li>
   </g:each>
   </div>
</ul>
</td><td valign='top'>

<div align="center">${sprint}</div>
<ul>
   <div id="sprintGroup" class="group">
   <g:each var="currStory" in="${sprint.stories}">
      <li id="story_${currStory.id}">${currStory}</li>
   </g:each>
   </div>
</ul>

</td></tr></table>

<br/><br/><hr/>
<g:link controller="sprint" action="show" id="${sprint.id}">go to the sprint</g:link>

</div>
</body>
</html>
