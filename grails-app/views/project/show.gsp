<html>
<head>
  <meta name="layout" content="main"/>
  <title>${project.name}</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo; 
  ${project.name}
</div>

<g:if test="${flash.message}">
  <div class="ruck-success">${flash.message}</div>
</g:if>

<div class="ruck-span-12">
  <fieldset style="margin-right: 10px;">
   <legend><g:link controller="backlog" id="${project.id}">backlog</g:link> has ${totalBacklogStoryPoints} points</legend>
    <ul>
      <g:each var="currStory" in="${topStories}">
        <li>${currStory}</li>
      </g:each>
    <g:if test="${moreStories > 0}">
      <li><g:link controller="backlog" id="${project.id}">...and ${moreStories} more</g:link></li>
    </g:if>
    </ul>
  </fieldset>
</div>

<g:if test="${showGraphs}">
<div class="ruck-span-11">
  <fieldset style="margin-left: 10px;">
   <legend>project burndown</legend>
   <img 
      width="400" height="200" 
      src="${request.contextPath}/chart?${burndownChartUrl}"/>
  </fieldset>
</div>
</g:if>

<g:if test="${showSprints}">
<div class="ruck-span-12">
  <fieldset style="margin-right: 10px;">
      <legend><g:link controller="sprint" action="list" id="${project.id}">sprints</g:link></legend>
    <ul>
      <!--g:each var="s" in="${project.sprints}"-->
      <g:each var="s" in="${topSprints}">
        <g:if test="${s.number != 0}">
          <li>
            <g:link controller="sprint" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link>
          </li>
        </g:if>
      </g:each>


    <g:if test="${moreSprints > 0}">
      <li><g:link controller="sprint" action="list" id="${project.id}">...and ${moreSprints} more</g:link></li>
    </g:if>



    </ul>
  </fieldset>
</div>
</g:if>

<g:if test="${showGraphs}">
<div class="ruck-span-11">
  <fieldset style="margin-left: 10px;">
      <legend>velocity</legend>
      <img 
         width="400" height="200" 
         src="${request.contextPath}/chart?${velocityChartUrl}"/>
  </fieldset>
</div>
</g:if>

<hr class="ruck-space"/>

<g:link 
   controller="project" 
   action="showText" 
   id="${project.id}" 
   params="[level:'task']">txt</g:link>


</body>
</html>
