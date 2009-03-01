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

<!--
<h3><em>Sprints are ${fieldValue(bean: project, field: 'sprintLength')} week(s) long
  starting on ${fieldValue(bean: project, field: 'startDate')}</em></h3>
  -->

<div class="ruck-span-12">
  <fieldset>
   <legend><g:link controller="backlog" id="${project.id}">backlog</g:link> has ${totalStoryPoints} points</legend>
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

<div class="ruck-span-11">
  <fieldset>
   <legend>burndown</legend>
      <img src="${request.contextPath}/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|1|2|3|4|1:||50|350&chs=400x200"/>
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


<div class="ruck-span-11">
  <fieldset>
      <legend>velocity</legend>
      <img src=
      "${request.contextPath}/chart?cht=bvg&chs=400x200&chxt=x,y&chxl=0:|1|2|3|3|4|5|&chco=ddddee&chd=t:60,57,78,48,63&chxr=1,10,33"/>
      <!-- all the data is 0-100, based on your top range you have to
           do the math to make it look right.  like if your top range was 33
           you need to multiply all of your values by 3 for it to match.  weird -->
      <!-- 100 / (MAX_RANGE) = MULTIPLIER
           DATAPOINT * MULTIPLIER= what you put in the data -->
  </fieldset>
</div>
<hr class="ruck-space"/>

<h1>${request.contextPath}/chart?${velocityChartUrl}</h1>
<img src="${request.contextPath}/chart?${velocityChartUrl}"/>


<h1>/ruck/chart?cht=bvg&chs=400x200&chxt=x,y&chco=dddee&chxl=0:|0|1|2|3|4|5|6|7|&chxr=1,0,18&chd=t:36,96,72,36,96,72,0</h1>
<img src="/ruck/chart?cht=bvg&chs=400x200&chxt=x,y&chco=dddee&chxl=0:|0|1|2|3|4|5|6|7|&chxr=1,0,18&chd=t:36,96,72,36,96,72,0"/>

</body>
</html>
