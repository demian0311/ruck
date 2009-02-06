<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main" />
<title>${project.name} | summary</title>
</head>
<body>

<div id="banner"><a href="/ruck">ruck</a> | 
<g:link controller="project" action="show" id="${project.id}">${project.name}</g:link> | 
summary</div>

<div id="content">
<g:if test="${flash.message}">
   <div class="message">${flash.message}</div>
</g:if>
<table><tr><td>
Sprints are ${fieldValue(bean:project, field:'sprintLength')} week(s) long.<br/>
The start date is ${fieldValue(bean:project, field:'startDate')}.

<h2>(${totalStoryPoints}) <g:link controller="backlog" id="${project.id}">backlog</g:link></h2>
<ul>
<g:each var="currStory" in="${backlog.stories}">
   <ul>${currStory}</ul>
</g:each>
</ul>

</td><td>&nbsp;</td><td>

<h2>sprints</h2>
<ul>
<g:each var="s" in="${project.sprints}">
   <g:if test="${s.number != 0}">
      <li>
         <g:link controller="sprint" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link>
      </li>
   </g:if>
</g:each>
</ul>

</td></tr></table>

</div></body></html>
