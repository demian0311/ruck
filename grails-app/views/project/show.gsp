<html>
<head>
  <meta name="layout" content="main"/>
  <title>${project.name} | summary</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo; 
  ${project.name}
</div>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<h3><em>Sprints are ${fieldValue(bean: project, field: 'sprintLength')} week(s) long
  starting on ${fieldValue(bean: project, field: 'startDate')}</em></h3>

<div class="ruck-span-11">
  <fieldset>
   <legend><g:link controller="backlog" id="${project.id}">backlog</g:link> has ${totalStoryPoints} points</legend>
    <ul>
      <g:each var="currStory" in="${topStories}">
        <li>${currStory}</li>
      </g:each>
    </ul>
    <g:if test="${moreStories > 0}">
      <g:link controller="backlog" id="${project.id}">...and ${moreStories} more</g:link>
    </g:if>
  </fieldset>
</div>

<div class="ruck-span-12">
  <fieldset>
      <legend>sprints</legend>
    <ul>
      <g:each var="s" in="${project.sprints}">
        <g:if test="${s.number != 0}">
          <li>
            <g:link controller="sprint" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link>
          </li>
        </g:if>
      </g:each>
    </ul>
  </fieldset>
</div>
<hr class="ruck-space"/>
</body>
</html>
