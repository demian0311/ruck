

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show TaskNote</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">TaskNote List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New TaskNote</g:link></span>
        </div>
        <div class="body">
            <h1>Show TaskNote</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:taskNoteInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Content:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:taskNoteInstance, field:'content')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Create Date:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:taskNoteInstance, field:'createDate')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Task:</td>
                            
                            <td valign="top" class="value"><g:link controller="task" action="show" id="${taskNoteInstance?.task?.id}">${taskNoteInstance?.task?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${taskNoteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
