<html>
<head>
<meta name="layout" content="main"/>
<title>${projectInstance.name} &raquo; sprints</title>
</head>
<body>

<div id="navigation">
   <a href="/ruck">ruck</a> &raquo;
   <g:link controller="project" action="show" id="${projectInstance.id}"
      >${projectInstance.name}</g:link> &raquo;
   sprints
</div>

<div class="body">
   <ul>
      <g:each in="${sprintInstanceList}" status="i" var="sprintInstance">
      <li>
         <g:link action="show" id="${sprintInstance.id}">${sprintInstance}</g:link>
      </li>
      </g:each>
   </ul>
</div>

</body>
</html>
