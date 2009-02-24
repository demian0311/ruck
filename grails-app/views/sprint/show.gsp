<html>
<head>
  <meta name="layout" content="main"/>
  <title>show sprint</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <a href="/ruck">ruck</a> |
  <g:link controller="project" action="show" id="${sprint.project.id}">${sprint.project.name}</g:link> |
  <g:link controller="sprint" action="show" id="${sprint.id}">${sprint}</g:link>
</div></div>
<hr class="ruck-space"/>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<div class="ruck-span-24">
  <div class="ruck-span-7 ruck-colborder">
    <h6>Story</h6>
    <hr/>
  </div>
  <div class="ruck-span-4">
    <h6>Not Started</h6>
    <hr/>
  </div>
  <div class="ruck-span-4">
    <h6>Working</h6>
    <hr/>
  </div>
  <div class="ruck-span-4">
    <h6>Verification</h6>
    <hr/>
  </div>
  <div class="ruck-span-4 ruck-last">
    <h6>Done</h6>
    <hr/>
  </div>
</div>

%{-- each of these blocks is a story's row --}%
<g:each var="currStory" in="${sprint.stories}" status="count">
  <div class="ruck-span-24 ${(count % 2)==0 ? '' : 'oddRow'}">
    <div class="ruck-span-7 ruck-colborder">
      <ul class="storyTitle">
        <li class="storyTitle" id="${currStory.id}"><g:link controller="story" action="show" id="${currStory.id}">${currStory.description}</g:link>
        %{-- are there any tasks? --}%
        <g:if test="${currStory.tasks.isEmpty()}">
          <br /><em>click on the story to add tasks</em>
        </g:if>
        </li>
      </ul>
    </div>
    %{-- not started --}%
    <div class="ruck-span-4">
      <g:if test="${!currStory.tasks.isEmpty()}">
        <ul class="task" id="notStartedGroup_${currStory.id}">
          <g:each var="currTask" in="${currStory.tasks}">
            <g:if test="${currTask.status == 'not started'}">
              <li class="task handle" id="task_${currTask.id}">${currTask}</li>
            </g:if>
          </g:each>
        </ul>
      </g:if>
    </div>
    %{-- working --}%
    <div class="ruck-span-4">
      <g:if test="${!currStory.tasks.isEmpty()}">
        <ul class="task" id="workingGroup_${currStory.id}">
          <g:each var="currTask" in="${currStory.tasks}">
            <g:if test="${currTask.status == 'working'}">
              <li class="task handle" id="task_${currTask.id}">${currTask}</li>
            </g:if>
          </g:each>
        </ul>
      </g:if>
    </div>
    %{-- verification --}%
    <div class="ruck-span-4">
      <g:if test="${!currStory.tasks.isEmpty()}">
        <ul class="task" id="verificationGroup_${currStory.id}">
          <g:each var="currTask" in="${currStory.tasks}">
            <g:if test="${currTask.status == 'verification'}">
              <li class="task handle" id="task_${currTask.id}">${currTask}</li>
            </g:if>
          </g:each>
        </ul>
      </g:if>
    </div>
    %{-- done --}%
    <div class="ruck-span-4 ruck-last">
      <g:if test="${!currStory.tasks.isEmpty()}">
        <ul class="task" id="doneGroup_${currStory.id}" class="dragGroup">
          <g:each var="currTask" in="${currStory.tasks}">
            <g:if test="${currTask.status == 'done'}">
              <li class="task handle" id="task_${currTask.id}">${currTask}</li>
            </g:if>
          </g:each>
        </ul>
      </g:if>
    </div>
  </div>
</g:each>

<br/> <br/>
<hr/>
<g:link controller="sprint" action="plan" id="${sprint.id}">add stories from backlog</g:link>
<br/>
<g:link controller="sprint" action="close" id="${sprint.id}">close this sprint</g:link>


<script type="text/javascript">
  var postUrl = '/ruck/sprint/moveTask/${sprint.id}'; // this is the ID of the story
  var taskboard;
  <g:each var="currStory" in="${sprint.stories}">
  // update methods for ${currStory}
  function updateNotStartedGroup_${currStory.id}() {
    var params = Sortable.serialize('notStartedGroup_${currStory.id}')
    params += '&newStatus=not started';
    var options = {
      method : 'post',
      parameters : params
    };
    new Ajax.Request(postUrl, options);
  }
  function updateWorkingGroup_${currStory.id}() {
    var params = Sortable.serialize('workingGroup_${currStory.id}');
    params += '&newStatus=working';
    var options = {
      method : 'post',
      parameters : params
    };
    new Ajax.Request(postUrl, options);
  }
  function updateVerificationGroup_${currStory.id}() {
    var params = Sortable.serialize('verificationGroup_${currStory.id}');
    params += '&newStatus=verification';
    var options = {
      method : 'post',
      parameters : params
    };
    new Ajax.Request(postUrl, options);
  }
  updateDoneGroup_${currStory.id} = function() {
    var params = Sortable.serialize('doneGroup_${currStory.id}');
    params += '&newStatus=done';
    var options = {
      method : 'post',
      parameters : params
    };
    new Ajax.Request(postUrl, options);
  }
  </g:each>

  document.observe("dom:loaded", function() {
    var columns = $w('notStartedGroup workingGroup verificationGroup doneGroup');
    taskboard = new TaskBoard(columns);
  <g:each var="currStory" in="${sprint.stories}">
  <g:if test="${!currStory.tasks.isEmpty()}"><!-- there are no stories -->
    var groups = [ 'notStartedGroup_${currStory.id}','workingGroup_${currStory.id}','verificationGroup_${currStory.id}', 'doneGroup_${currStory.id}']
    Sortable.create('notStartedGroup_${currStory.id}', {
      ghosting:'true', // keep original in place and show a ghost
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        taskboard.updateHeight('notStartedGroup_${currStory.id}');
        updateNotStartedGroup_${currStory.id}();
      }
    });

    Sortable.create('workingGroup_${currStory.id}', {
      ghosting:'true',
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        taskboard.updateHeight('workingGroup_${currStory.id}');
        updateWorkingGroup_${currStory.id}();
      }
    });

    Sortable.create('verificationGroup_${currStory.id}', {
      ghosting:'true', // keep original in place and show a ghost
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        taskboard.updateHeight('verificationGroup_${currStory.id}');
        updateVerificationGroup_${currStory.id}();
      }
    });

    Sortable.create('doneGroup_${currStory.id}', {
      ghosting:'true',
      dropOnEmpty: true,
      containment: groups,
      constraint: false,
      onUpdate: function() {
        taskboard.updateHeight('doneGroup_${currStory.id}');
        updateDoneGroup_${currStory.id}();
      }
    });
  </g:if>
  </g:each>
  });
</script>
</body>
</html>
