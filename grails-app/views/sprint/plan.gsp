<html>
<head>
  <meta name="layout" content="main"/>
  <title>Sprint Plan</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <a href="/ruck">ruck</a> | <g:link controller="project" action="show" id="${sprint.project.id}">${sprint.project.name}</g:link> |
  <g:link controller="sprint" action="show" id="${sprint.id}">${sprint}</g:link> | <a href="">plan</a>
</div></div>
<hr class="ruck-space"/>

<div class="ruck-span-12">
  <fieldset>
    <legend>${backlog}</legend>
    <ul id="stories" class="story">
      <g:each var="currStory" in="${backlog.stories}">
        <li id="story_${currStory.id}" class="story handle">${currStory}</li>
      </g:each>
    </ul>
  </fieldset>
</div>
<div class="ruck-span-12 ruck-last">
  <fieldset>
    <legend>${sprint}</legend>
    <ul id="sprintGroup" class="story">
      <g:each var="currStory" in="${sprint.stories}">
        <li id="story_${currStory.id}" class="story handle">${currStory}</li>
      </g:each>
    </ul>
  </fieldset>
</div>

<h1>Total:<span id="total">0</span></h1>

<script type="text/javascript">
  var groups = $w('stories sprintGroup');
  updateBacklogPlan = function() {
    var options = {
      method : 'post',
      parameters : Sortable.serialize('stories')
    };
    new Ajax.Request('/ruck/backlog/order/${backlog.id}', options);
  },

  updateSprintPlan = function() {
    var options = {
      method : 'post',
      parameters : Sortable.serialize('sprintGroup')
    };
    new Ajax.Request('/ruck/sprint/order/${sprint.id}', options);
  },

  adjustHeight = function() {
    var overflowHeight = 15;
    var preferredHeight = $('stories').getHeight() + overflowHeight;
    if($('sprintGroup').getHeight() > preferredHeight)
      preferredHeight = $('sprintGroup').getHeight() + overflowHeight;
    $('stories').up().setStyle({height: preferredHeight + 'px'});
    $('sprintGroup').up().setStyle({height: preferredHeight + 'px'});
    if($('stories').childElements().size() < 1)
      $('stories').setStyle({height: (preferredHeight - overflowHeight) + "px"});
    if($('sprintGroup').childElements().size() < 1)
      $('sprintGroup').setStyle({height: (preferredHeight - overflowHeight) + "px"});
    var totalPoints = 0;
    $('sprintGroup').childElements().each(function(e){
       var leftSide = e.innerHTML.split(")");
       var number = leftSide[0].split("(");
       totalPoints += (number[1] * 1);
    });
    $('total').innerHTML = totalPoints;
  },

  document.observe("dom:loaded", function() {
    adjustHeight();
    Sortable.create('stories', {
      ghosting:'true',
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        updateBacklogPlan();
        adjustHeight();
      }
    });

    Sortable.create('sprintGroup', {
      ghosting:'true',
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        updateSprintPlan();
        adjustHeight();
      }
    });
  });
</script>

</body>
</html>
