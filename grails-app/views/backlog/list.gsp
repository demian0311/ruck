<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>${project.name} | backlog</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <a href="/ruck">ruck</a> | <g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> | backlog(${totalStoryPoints})
</div></div>
<hr class="ruck-space"/>

<g:if test="${flash.message}">
  <div class="ruck-notice">${flash.message}</div>
</g:if>

<% numStories = 0 %>

<div id="backlogGroup">
  <ul>
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
          <g:link controller="backlog" action="deletestory" id="${storyInstance.id}">delete</g:link>
          }
        </i>
      </li>
    </g:each>
  </ul>
</div>

<g:form action="save" method="post">
  (<input type="text" tabindex="1" size="1" id="points" name="points" class="ruck-title" value="${fieldValue(bean: storyInstance, field: 'points')}"/>)
  <input type="text" tabindex="2" size="75" id="description" name="description" class="ruck-text" value="${fieldValue(bean: storyInstance, field: 'description')}"/>
  <input type="hidden" name="ordinal" value="<%=numStories%>"/>
  <input type="hidden" name="projectId" value="<%=project.id%>"/>
  <input type="hidden" name="sprint" value="<%=backlog.id%>"/>
  <input class="save" tabindex="3" type="submit" value="+"/>
</g:form>

<g:if test="${backlog.stories.isEmpty()}">
  <div class="ruck-span-10 ruck-prepend-5">
    <fieldset>
      <h6>This is where you add new stories to your backlog.</h6>
      <p>The <strong>first field (in parens) is the story points</strong>.
      Story points are unitless but they convey the relative
      complexity of a story.  Points come from developers,
      priorities come from product owners.<br/><br/>
        The <strong>second field is the story</strong>.  Until you get into working
      on a sprint, stories are the unit of work.
      For now just come up with lots of stories that will make up
      a system you want to ship.  You can add stories later and
      re-shuffle the priority.<br/>
        Stories are usually of the form <em>as a blah I want to do blah so that blah</em>.<br/>
        Having trouble finding inspiration?  How about:</p>
      <blockquote>
        <strong>(3) as a user I want to log in so I can access the system</strong>
      </blockquote>
    </fieldset>
  </div>
</g:if>

<%//javascript placed below main content%>
<script type="text/javascript">
function updateOrder() {
   var options = {
      method : 'post',
      parameters : Sortable.serialize('backlogGroup')
   };
   new Ajax.Request('order/${backlog.id}', options);
}

Event.observe(window, 'load', function() {
   Sortable.create ('backlogGroup', // the div id we're going to sort
    {
         ghosting:'true', // keep original in place and show a ghost
         onUpdate:updateOrder,
         handle: 'handle'
    });

   <g:each in="${backlog.stories}" status="ii" var="storyInstance">
      new Ajax.InPlaceEditor (
         'story_points_${storyInstance.id}',
         'changestorypoints/${storyInstance.id}', // server side resource
         {
            cols: 2,
            okControl: false,
            cancelControl: false
         });

      new Ajax.InPlaceEditor (
         'story_description_${storyInstance.id}',
         'changestorydescription/${storyInstance.id}', // server side resource
         {
            cols: 75,
            okControl: false,
            cancelControl: false
         });
   </g:each>
});
</script>

</body>
</html>
