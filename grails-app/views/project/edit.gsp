<html>
<head>
  <meta name="layout" content="main"/>
  <title>Edit Project</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">Project List</g:link></span>
  <span class="menuButton"><g:link class="create" action="create">New Project</g:link></span>
</div>
<div class="body">
  <h1>Edit Project</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${projectInstance}">
    <div class="errors">
      <g:renderErrors bean="${projectInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <input type="hidden" name="id" value="${projectInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name">Name:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'name', 'errors')}">
            <input type="text" id="name" name="name" value="${fieldValue(bean: projectInstance, field: 'name')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description">Description:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'description', 'errors')}">
            <input type="text" id="description" name="description" value="${fieldValue(bean: projectInstance, field: 'description')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="sprintLength">Sprint Length:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'sprintLength', 'errors')}">
            <input type="text" id="sprintLength" name="sprintLength" value="${fieldValue(bean: projectInstance, field: 'sprintLength')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="startDate">Start Date:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'startDate', 'errors')}">
            <g:datePicker name="startDate" value="${projectInstance?.startDate}"></g:datePicker>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="sprints">Sprints:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'sprints', 'errors')}">

            <ul>
              <g:each var="s" in="${projectInstance?.sprints?}">
                <li><g:link controller="sprint" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
            <g:link controller="sprint" params="['project.id':projectInstance?.id]" action="create">Add Sprint</g:link>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" value="Update"/></span>
      <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
