

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Sprint</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Sprint List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Sprint</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Sprint</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${sprintInstance}">
            <div class="errors">
                <g:renderErrors bean="${sprintInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${sprintInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="number">Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:sprintInstance,field:'number','errors')}">
                                    <input type="text" id="number" name="number" value="${fieldValue(bean:sprintInstance,field:'number')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:sprintInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:sprintInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="goal">Goal:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:sprintInstance,field:'goal','errors')}">
                                    <input type="text" id="goal" name="goal" value="${fieldValue(bean:sprintInstance,field:'goal')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="project">Project:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:sprintInstance,field:'project','errors')}">
                                    <g:select optionKey="id" from="${Project.list()}" name="project.id" value="${sprintInstance?.project?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="stories">Stories:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:sprintInstance,field:'stories','errors')}">
                                    
<ul>
<g:each var="s" in="${sprintInstance?.stories?}">
    <li><g:link controller="story" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="story" params="['sprint.id':sprintInstance?.id]" action="create">Add Story</g:link>

                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
