<html>
<head>
  <meta name="layout" content="main"/>
  <title></title>
</head>
<body>

<div id="navigation">
  <a href="/ruck">ruck</a>
</div>


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
        <input type="text" name="name" id="name" class="ruck-text" size="30" value="${fieldValue(bean: projectInstance, field: 'name')}"/>
      </p>
      <p>
        <label for="description">Description</label><br/>
        <input type="text" class="ruck-text" id="description" name="description" size="30" value="${fieldValue(bean: projectInstance, field: 'description')}"/>
      </p>
      <button type="submit" class="positive"><img src="${createLinkTo(dir: 'images/icons', file: 'tick.png')}" alt=""/>create project</button>
    </g:form>
  </fieldset>
</div>
</body>
</html>
