<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main" />
<title>${project.name} | backlog</title>
</head>
<body>

<div id="banner"><a href="/ruck">ruck</a> | <g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> | backlog 
(${totalStoryPoints})</div>
<div id="content">
<g:if test="${flash.message}">
<div class="message">${flash.message}</div>
</g:if>

<script type="text/javascript">
function updateOrder()
{
   var options = 
   {
      method : 'post',
      parameters : Sortable.serialize('backlogGroup')
   };
   new Ajax.Request('order/${backlog.id}', options);
}

Event.observe(window, 'load', function() 
{
   Sortable.create
   (
      'backlogGroup', // the div id we're going to sort
      {
         ghosting:'true', // keep original in place and show a ghost
         onUpdate:updateOrder,
         handle: 'handle'
      }
   );

   <g:each in="${backlog.stories}" status="ii" var="storyInstance">
      new Ajax.InPlaceEditor
      (
         'story_points_${storyInstance.id}', 
         'changestorypoints/${storyInstance.id}', // server side resource
         {
            cols: 2,
            okControl: false,
            cancelControl: false
         }
      );

      new Ajax.InPlaceEditor
      (
         'story_description_${storyInstance.id}', 
         'changestorydescription/${storyInstance.id}', // server side resource
         {
            cols: 75,
            okControl: false,
            cancelControl: false
         }
      );
   </g:each>
});
</script>

<% numStories = 0 %>
<ul>
<div id="backlogGroup">
   <g:each in="${backlog.stories}" status="ii" var="storyInstance">
      <% numStories++ %>

      <li id="story_${storyInstance.id}" 
         onmouseout="$('tool_${storyInstance.id}').hide();"
         onmouseover="$('tool_${storyInstance.id}').show();">
         (<i id="story_points_${storyInstance.id}">${storyInstance.points}</i>)
         <i id="story_description_${storyInstance.id}">${storyInstance.description}</i>
         <i id="tool_${storyInstance.id}" style="display: none">
            {
               <i class='handle'>move</i>
               <g:link controller="backlog" action="deletestory" id="${storyInstance.id}"
                  >delete</g:link>
            }
         </i>
      </li>
   </g:each>
</div>
</ul>

<g:form action="save" method="post" >
(<input type="text" tabindex="1" size="1" id="points" name="points" 
         value="${fieldValue(bean:storyInstance,field:'points')}" />)
      <input type="text" tabindex="2" size="75" id="description" name="description" 
         value="${fieldValue(bean:storyInstance,field:'description')}"/>

      <input type="hidden" name="ordinal" value="<%=numStories%>"/>
      <input type="hidden" name="projectId" value="<%=project.id%>"/>
      <input type="hidden" name="sprint" value="<%=backlog.id%>"/>
      <input class="save" tabindex="3" type="submit" value="+" />
</g:form>

<g:if test="${backlog.stories.isEmpty()}">
This is where you add new stories to your backlog.
<br/>
<br/>
The <b>first field (in parens) is the story points</b>.
Story points are unitless but they convey the relative
complexity of a story.  Points come from developers, 
priorities come from product owners.
<br/>
<br/>
The <b>second field is the story</b>.  Until you get into working
on a sprint, stories are the unit of work.
For now just come up with lots of stories that will make up
a system you want to ship.  You can add stories later and
re-shuffle the priority.
<br/>
<br/>
Stories are usually of the form <i>as a blah I want to do blah so that blah</i>.
<br/>
<br/>
Having trouble finding inspiration?  How about... 
<br/>
<b>(3) as a user I want to log in so I can access the system</b>
</g:if>

<g:if test="${!backlog.stories.isEmpty()}">
   <br/>
   <br/>
   <hr/>
   <g:link controller="project" action="show" id="${project.id}">done for now, go back to the project</g:link>
</g:if>

</div><!-- content -->
</body>
</html>
