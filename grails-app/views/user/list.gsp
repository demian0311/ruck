<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>user</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo; user
</div>

<div class="body">

  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <ul>
  <g:each in="${personList}" var="userInstance">
    <li><g:link action="show" id="${userInstance.id}">${userInstance}</g:link></li>
      </g:each>
  </ul>
<g:link class="create" action="create">create</g:link> a new user

</div>
</body>
</html>
