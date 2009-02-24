<html>
<head>
  <meta name="layout" content="main"/>
  <title>${project.name} | summary</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> | summary
</div></div>
<hr class="ruck-space"/>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<hr />
<h3><em>Sprints are ${fieldValue(bean: project, field: 'sprintLength')} week(s) long
  starting on ${fieldValue(bean: project, field: 'startDate')}</em></h3>
<hr />

<div class="ruck-span-11 ruck-colborder">
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

<div class="ruck-span-12 ruck-last">
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
