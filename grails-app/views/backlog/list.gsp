<html>
<head>
  <meta name="layout" content="main"/>
  <title>${project.name} | backlog</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo; 
  <g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> &raquo; 
  backlog
</div>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<g:if test="${!backlog.stories.isEmpty()}">
  <div class="ruck-span-24">
    <fieldset>
      <legend>backlog has ${totalStoryPoints} points</legend>
      <ul class="story" id="stories">
        <g:each in="${backlog.stories}" status="ii" var="storyInstance">
          <li class="story" id="story_${storyInstance.id}" onmouseout="$('tool_${storyInstance.id}').hide();" onmouseover="$('tool_${storyInstance.id}').show();">
            (<span id="story_points_${storyInstance.id}">${storyInstance.points}</span>) 
            <span id="story_description_${storyInstance.id}">${storyInstance.description}</span>

            <span id="tool_${storyInstance.id}" style="display: none">{<span id="handle">move</span>
              <g:link controller="backlog" action="deletestory" id="${storyInstance.id}">delete</g:link>}
            </span>
          </li>
        </g:each>
      </ul>

<g:form action="save" method="post">
    <table><tr><td>
    ( <input type="text" tabindex="1" size="1" id="points" name="points" class="ruck-text" value="${fieldValue(bean: storyInstance, field: 'points')}"/> )
    </td><td>
    <input type="text" tabindex="2" size="75" id="description" name="description" class="ruck-text" value="${fieldValue(bean: storyInstance, field: 'description')}"/>
    </td><td>
    <input type="hidden" name="ordinal" value="<%=numStories + 1%>"/>
    <input type="hidden" name="projectId" value="<%=project.id%>"/>
    <input type="hidden" name="sprint" value="<%=backlog.id%>"/>
    <button type="submit" tabindex="3" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt="add"/>add</button>
    </td></tr></table>
  </fieldset>
</g:form>



    </fieldset>
  </div>
</g:if>

<g:else>
  <div id="stories" class="ruck-span-24">
    <fieldset>
      <h6>This is where you add new stories to your backlog</h6>
      <hr/>
      <p>The <strong>first field (in parens) is the story points</strong>.
      Story points are unitless but they convey the relative
      complexity of a story.  Points come from developers,
      priorities come from product owners.<br/><br/>
        The <strong>second field is the story</strong>.  Until you get into working
      on a sprint, stories are the unit of work.
      For now just come up with lots of stories that will make up
      a system you want to ship.  You can add stories later and
      re-shuffle the priority.<br/><br />
        Stories are usually of the form <em>as a blah I want to do blah so that blah</em>.<br/>
        Having trouble finding inspiration?  How about:</p>
      <blockquote>
        <strong>(3) as a user I want to log in so I can access the system</strong>
      </blockquote>
    </fieldset>
  </div>
</g:else>
<hr class="ruck-space"/>

<% //javascript placed below main content %>
<script type="text/javascript">
  function updateOrder() {
    var options = {
      method : 'post',
      parameters : Sortable.serialize('stories')
    };
    new Ajax.Request('order/${backlog.id}', options);
  }

  Event.observe(window, 'load', function() {
    Sortable.create('stories', {
      ghosting:'true',
      onUpdate:updateOrder,
      handle: 'handle'
    });

  <g:each in="${backlog.stories}" status="ii" var="storyInstance">
    new Ajax.InPlaceEditor('story_points_${storyInstance.id}','changestorypoints/${storyInstance.id}', {
      cols: 2,
      okControl: false,
      cancelControl: false
    });

    new Ajax.InPlaceEditor('story_description_${storyInstance.id}', 'changestorydescription/${storyInstance.id}', {
      cols: 75,
      okControl: false,
      cancelControl: false
    });
  </g:each>
  });
</script>

</body>
</html>
