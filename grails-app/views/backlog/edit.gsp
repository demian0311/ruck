

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Story</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Story List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Story</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Story</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${storyInstance}">
            <div class="errors">
                <g:renderErrors bean="${storyInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${storyInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="points">Points:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:storyInstance,field:'points','errors')}">
                                    <input type="text" id="points" name="points" value="${fieldValue(bean:storyInstance,field:'points')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:storyInstance,field:'description','errors')}">
                                    <input type="text" id="description" name="description" value="${fieldValue(bean:storyInstance,field:'description')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ordinal">Ordinal:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:storyInstance,field:'ordinal','errors')}">
                                    <input type="text" id="ordinal" name="ordinal" value="${fieldValue(bean:storyInstance,field:'ordinal')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sprint">Sprint:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:storyInstance,field:'sprint','errors')}">
                                    <g:select optionKey="id" from="${Sprint.list()}" name="sprint.id" value="${storyInstance?.sprint?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tasks">Tasks:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:storyInstance,field:'tasks','errors')}">
                                    
<ul>
<g:each var="t" in="${storyInstance?.tasks?}">
    <li><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="task" params="['story.id':storyInstance?.id]" action="create">Add Task</g:link>

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
