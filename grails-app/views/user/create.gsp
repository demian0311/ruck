<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>user &raquo; create</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo;
  <g:link controller="user" action="list">user</g:link> &raquo;
  create
</div>

<div class="body">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${person}">
    <div class="errors">
      <g:renderErrors bean="${person}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="username">username</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'username', 'errors')}">
            <input type="text" id="username" name="username" value="${fieldValue(bean: person, field: 'username')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="userRealName">real name</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'userRealName', 'errors')}">
            <input type="text" id="userRealName" name="userRealName" value="${fieldValue(bean: person, field: 'userRealName')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="password">password</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'password', 'errors')}">
            <input type="password" id="password" name="password" value="${fieldValue(bean: person, field: 'password')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="email">email</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
            <input type="text" id="email" name="email" value="${fieldValue(bean: person, field: 'email')}"/>
          </td>
        </tr>

        <input type="hidden" name="enabled" value="true"/>
        <input type="hidden" name="emailShow" value="true"/>

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
