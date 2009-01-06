

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Story List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Story</g:link></span>
        </div>
        <div class="body">
            <h1>Story List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="description" title="Description" />
                        
                   	        <g:sortableColumn property="ordinal" title="Ordinal" />
                        
                   	        <g:sortableColumn property="points" title="Points" />
                        
                   	        <th>Sprint</th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${storyInstanceList}" status="i" var="storyInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${storyInstance.id}">${fieldValue(bean:storyInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:storyInstance, field:'description')}</td>
                        
                            <td>${fieldValue(bean:storyInstance, field:'ordinal')}</td>
                        
                            <td>${fieldValue(bean:storyInstance, field:'points')}</td>
                        
                            <td>${fieldValue(bean:storyInstance, field:'sprint')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Story.count()}" />
            </div>
        </div>
    </body>
</html>
