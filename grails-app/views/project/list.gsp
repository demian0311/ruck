<html>
<head>
  <meta name="layout" content="main"/>
  <title></title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a>
</div>

<g:hasErrors bean="${projectInstance}">
<div class="ruck-error"><g:renderErrors bean="${projectInstance}" as="list"/></div>
</g:hasErrors>

  <div class="ruck-span-12">
    <fieldset style="margin-right: 10px;">
      <legend>projects</legend>
      <g:if test="${flash.message}">
        <div class="ruck-notice">${flash.message}</div>
      </g:if>
      <ul>
        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
          <li>
            <g:link action="show" id="${projectInstance.id}">${projectInstance}</g:link>
          </li>
        </g:each>

      <g:form action="save" method="post">
        <li>
          <input type="text" name="name" id="name" class="ruck-text" size="10" value="${fieldValue(bean: projectInstance, field: 'name')}"/>
          -
          <input type="text" class="ruck-text" id="description" name="description" size="20" value="${fieldValue(bean: projectInstance, field: 'description')}"/>
          <input type="submit" value="create new project"/>
    </g:form>
      </ul>

    </fieldset>
  </div>

<div class="ruck-span-12 ruck-last">
  <fieldset style="margin-left: 10px;">
    <legend><g:link controller="user" action="list">users</g:link></legend>
    <ul>
      <g:each in="${personList}" var="userInstance">
        <li><g:link controller="user" action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: 'username')}</g:link>
      </g:each>
    </ul>
  </fieldset>
</div>
</body>
</html>
