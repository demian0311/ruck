<html>
<head>
  <meta name="layout" content="main"/>
  <title>pick project</title>
</head>
<body>

<div id="navigation"><div class="ruck-nav-left"/><div class="ruck-nav-right">
  <a href="/ruck">ruck</a> | pick project
</div></div>
<hr class="ruck-space"/>

<g:if test="${!projectInstanceList.isEmpty()}">
  <div class="ruck-span-12">
    <fieldset>
      <legend>Pick an Existing Project</legend>
      <g:if test="${flash.message}">
        <div class="ruck-notice">${flash.message}</div>
      </g:if>
      <ul>
        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
          <li>
            <g:link action="show" id="${projectInstance.id}">${projectInstance}</g:link>
          </li>
        </g:each>
      </ul>
    </fieldset>
  </div>
</g:if><% // there are some projects %>

<div class="ruck-span-12 ruck-last">
  <fieldset>
    <legend>Create a New Project</legend>
    <g:hasErrors bean="${projectInstance}">
      <div class="ruck-error"><g:renderErrors bean="${projectInstance}" as="list"/></div>
    </g:hasErrors>
    <g:form action="save" method="post">
      <p>
        <label for="name">Project name</label> <br/>
        <input type="text" name="name" id="name" class="ruck-text" value="${fieldValue(bean: projectInstance, field: 'name')}"/>
      </p>
      <p>
        <label for="description">Description</label><br/>
        <input type="text" class="ruck-text" id="description" name="description" value="${fieldValue(bean: projectInstance, field: 'description')}"/>
      </p>
      <button type="submit" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt=""/>create project</button></td>
    </g:form>
  </fieldset>
</div>
</body>
</html>
