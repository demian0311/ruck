

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>TaskNote List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New TaskNote</g:link></span>
        </div>
        <div class="body">
            <h1>TaskNote List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="content" title="Content" />
                        
                   	        <g:sortableColumn property="createDate" title="Create Date" />
                        
                   	        <th>Task</th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${taskNoteInstanceList}" status="i" var="taskNoteInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${taskNoteInstance.id}">${fieldValue(bean:taskNoteInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:taskNoteInstance, field:'content')}</td>
                        
                            <td>${fieldValue(bean:taskNoteInstance, field:'createDate')}</td>
                        
                            <td>${fieldValue(bean:taskNoteInstance, field:'task')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${TaskNote.count()}" />
            </div>
        </div>
    </body>
</html>
