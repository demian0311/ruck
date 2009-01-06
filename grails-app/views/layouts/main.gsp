<html>
    <head>
        <title>ruck | <g:layoutTitle/></title>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />				
        <g:javascript library="prototype" />
        <g:javascript library="scriptaculous" />
    </head>
    <body>
        <g:layoutBody />		
    </body>	
    <div id="footer">
         ${new Date()} | 
         <a href="http://github.com/demian0311/ruck/tree/master"
         >ruck</a>&nbsp;&nbsp;
   </div>

</html>
