<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>user &raquo; edit &raquo ${person.username}</title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a> &raquo;
  <g:link controller="user" action="list">user</g:link> &raquo;
  edit &raquo
  ${person.username}
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
  <g:form method="post">
    <input type="hidden" name="id" value="${person?.id}"/>
    <input type="hidden" name="version" value="${person?.version}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="authorities">roles</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'authorities', 'errors')}">
              <g:each var="entry" in="${roleMap}">
                <g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
                ${entry.key.authority.encodeAsHTML()}<br/>
              </g:each>
          </td>

          <td valign="top" class="value ${hasErrors(bean: person, field: 'authorities', 'errors')}"></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="email">email</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
            <input type="text" id="email" name="email" value="${fieldValue(bean: person, field: 'email')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description">description</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'description', 'errors')}">
            <input type="text" id="description" name="description" value="${fieldValue(bean: person, field: 'description')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="enabled">enabled</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'enabled', 'errors')}">
            <g:checkBox name="enabled" value="${person?.enabled}"></g:checkBox>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" value="Update"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
