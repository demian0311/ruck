<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>user &raquo; ${person.username}</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo;
  <g:link controller="user" action="list">user</g:link> &raquo;
  ${person.username}
</div>

<div class="body">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">Id:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'id')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Username:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'username')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">User Real Name:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'userRealName')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Password:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'password')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Enabled:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'enabled')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Authorities:</td>
        <td valign="top" style="text-align:left;" class="value">
          <ul>
            <g:each var="a" in="${person.authorities}">
              <li><g:link controller="role" action="show" id="${a.id}">${a?.authority}</g:link></li>
            </g:each>
          </ul>
        </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Description:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'description')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Email:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'email')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Email Show:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'emailShow')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Pass:</td>

        <td valign="top" class="value">${fieldValue(bean: person, field: 'pass')}</td>

      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <g:form>
      <input type="hidden" name="id" value="${person?.id}"/>
      <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
    </g:form>
  </div>
</div>
</body>
</html>
