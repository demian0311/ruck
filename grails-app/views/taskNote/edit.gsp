

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit TaskNote</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">TaskNote List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New TaskNote</g:link></span>
        </div>
        <div class="body">
            <h1>Edit TaskNote</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${taskNoteInstance}">
            <div class="errors">
                <g:renderErrors bean="${taskNoteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${taskNoteInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">Content:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskNoteInstance,field:'content','errors')}">
                                    <input type="text" id="content" name="content" value="${fieldValue(bean:taskNoteInstance,field:'content')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createDate">Create Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskNoteInstance,field:'createDate','errors')}">
                                    <g:datePicker name="createDate" value="${taskNoteInstance?.createDate}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="task">Task:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:taskNoteInstance,field:'task','errors')}">
                                    <g:select optionKey="id" from="${Task.list()}" name="task.id" value="${taskNoteInstance?.task?.id}" ></g:select>
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
