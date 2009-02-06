<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>pick project</title>
    </head>
    <body>

<div id="banner"><a href="/ruck">ruck</a> | pick project</div>
<div id="content">
<g:if test="${!projectInstanceList.isEmpty()}">
   <h2>pick an existing project</h2>
   <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
   </g:if>

   <ul>
         <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                  <li>
                  <g:link action="show" id="${projectInstance.id}">${projectInstance}</g:link>
                  </li>
         </g:each>
   </ul>

<br/>
<br/>
</g:if><!-- there are some projects -->
<h2>create a new project</h2>
   <g:hasErrors bean="${projectInstance}">
   <div class="errors"><g:renderErrors bean="${projectInstance}" as="list" /></div>
   </g:hasErrors>
   <g:form action="save" method="post" >
      <table><tr><td>project name</td><td>
                     <input type="text" id="name" name="name" value="${fieldValue(bean:projectInstance,field:'name')}"/>
                     </td></tr>
      <tr><td>description</td><td>
                     <input type="text" id="description" name="description" value="${fieldValue(bean:projectInstance,field:'description')}"/>
                     </td></tr>

      <tr>
         <td>&nbsp;</td>
         <td><input class="button" class="save" type="submit" value="create project" /></td>
      </tr></table>
   </g:form>

        </div>
    </body>
</html>
