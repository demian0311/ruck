<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Role List</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="create" action="create">New Role</g:link></span>
</div>
<div class="body">
  <h1>Role List</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>
        <g:sortableColumn property="id" title="Id"/>
        <g:sortableColumn property="authority" title="Authority"/>
        <g:sortableColumn property="description" title="Description"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${authorityList}" status="i" var="roleInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: 'id')}</g:link></td>

          <td>${fieldValue(bean: roleInstance, field: 'authority')}</td>

          <td>${fieldValue(bean: roleInstance, field: 'description')}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
