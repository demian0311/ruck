<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Create Role</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">Role List</g:link></span>
</div>
<div class="body">
  <h1>Create Role</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${authority}">
    <div class="errors">
      <g:renderErrors bean="${authority}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="authority">Authority:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: authority, field: 'authority', 'errors')}">
            <input type="text" id="authority" name="authority" value="${fieldValue(bean: authority, field: 'authority')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description">Description:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: authority, field: 'description', 'errors')}">
            <input type="text" id="description" name="description" value="${fieldValue(bean: authority, field: 'description')}"/>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><input class="save" type="submit" value="Create"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
