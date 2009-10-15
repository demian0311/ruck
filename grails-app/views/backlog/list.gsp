<html>
<head>
  <meta name="layout" content="main"/>
  <script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'ruckbackloginplace.js')}">
  </script>
  <title>${project.name} &raquo; backlog</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo;
  <g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> &raquo; 
  backlog
</div>

<pre>
  project: ${project}
</pre>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

  <div class="ruck-span-24">
    <fieldset>
      <legend>backlog has ${totalStoryPoints} points</legend>
      <ul class="story" id="stories">
        <g:each in="${backlog.stories}" status="ii" var="storyInstance">
          <li class="story handle" id="story_${storyInstance.id}">
            <span id="story_update_${storyInstance.id}">(${storyInstance.points}) ${storyInstance.description}</span>
            <a href="#" onclick="ruckBacklogInPlace('story_update_${storyInstance.id}', this);return false;">Update</a>
          </li>
        </g:each>
      </ul>

<g:form action="save" method="post">
    <input class="ruck-text" 
      type="text" tabindex="1" size="2" id="points" name="points" class="ruck-text"/> 
    <input 
      type="text" tabindex="2" size="75" id="description" name="description" class="ruck-text"/>
    <input type="hidden" name="ordinal" value="<%=numStories + 1%>"/>
    <input type="hidden" name="projectId" value="<%=project.id%>"/>
    <input type="hidden" name="sprint" value="<%=backlog.id%>"/>

    <button type="submit" tabindex="3" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt="add"/>add</button>
</g:form>


<g:if test="${backlog.stories.isEmpty()}">
      <h6>This is where you add new stories to your backlog</h6>
      <p>The <strong>first field (in parens) is the story points</strong>.
      Story points are unitless but they convey the relative
      complexity of a story.  Points come from developers,
      priorities come from product owners.<br/><br/>
        The <strong>second field is the story</strong>.  
        Until you get into working
      on a sprint, stories are the unit of work.
      For now just come up with lots of stories that will make up
      a system you want to ship.  You can add stories later and
      re-shuffle the priority.<br/><br />
        Stories are usually of the form <em>as a blah I want to do blah so that blah</em>.<br/>
        Having trouble finding inspiration?  How about:</p>
      <blockquote>
        <strong>(3) as a user I want to log in so I can access the system</strong>
      </blockquote>
</g:if>

    </fieldset>
  </div>

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
      onUpdate:updateOrder      
    });
  });
</script>

</body>
</html>
