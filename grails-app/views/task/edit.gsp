

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Task</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Task List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Task</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Task</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${taskInstance}">
            <div class="errors">
                <g:renderErrors bean="${taskInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${taskInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:taskInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status">Status:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'status','errors')}">
                                    <g:select id="status" name="status" from="${taskInstance.constraints.status.inList}" value="${taskInstance.status}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hoursEstimate">Hours Estimate:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'hoursEstimate','errors')}">
                                    <input type="text" id="hoursEstimate" name="hoursEstimate" value="${fieldValue(bean:taskInstance,field:'hoursEstimate')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hoursActual">Hours Actual:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'hoursActual','errors')}">
                                    <input type="text" id="hoursActual" name="hoursActual" value="${fieldValue(bean:taskInstance,field:'hoursActual')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notes">Notes:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'notes','errors')}">
                                    
<ul>
<g:each var="n" in="${taskInstance?.notes?}">
    <li><g:link controller="taskNote" action="show" id="${n.id}">${n?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="taskNote" params="['task.id':taskInstance?.id]" action="create">Add TaskNote</g:link>

                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="story">Story:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskInstance,field:'story','errors')}">
                                    <g:select optionKey="id" from="${Story.list()}" name="story.id" value="${taskInstance?.story?.id}" ></g:select>
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
