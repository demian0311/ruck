<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main" />
<title>${projectInstance.name} | summary</title>
</head>
<body>

<div id="banner"><a href="/ruck">ruck</a> | 
<g:link controller="project" action="show" id="${projectInstance.id}">${projectInstance.name}</g:link> | 
summary</div>

<div id="content">
<g:if test="${flash.message}">
   <div class="message">${flash.message}</div>
</g:if>

<table><tr><td>
<h2>${projectInstance}</h2>
Sprints are ${fieldValue(bean:projectInstance, field:'sprintLength')} week(s) long.<br/>
The start date is ${fieldValue(bean:projectInstance, field:'startDate')}.

<h2>management tasks</h2>
<ul>
   <li><g:link controller="backlog" id="${projectInstance.id}">manage backlog</g:link>
</ul>

</td><td>&nbsp;</td><td>

<h2>sprints</h2>
<ul>
<g:each var="s" in="${projectInstance.sprints}">
   <g:if test="${s.number != 0}">
      <li>
         <g:link controller="sprint" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link>
      </li>
   </g:if>
</g:each>
</ul>

</td></tr></table>

</div></body></html>
