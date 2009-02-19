<html>
<head>
  <title>ruck | <g:layoutTitle/></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'screen.css')}" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'navigation.css')}" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'print.css')}" type="text/css" media="print">
  <!--[if IE]>
    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'ie.css')}" type="text/css" media="screen, projection">
  <![endif]-->
  <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  <g:layoutHead/>
  <g:javascript library="application"/>
  <g:javascript library="prototype"/>
  <g:javascript library="scriptaculous"/>
  <g:javascript library="taskboard"/>
</head>
<body>
<div class="ruck-container ">
  <g:layoutBody/>
  <div id="footer">${new Date()} | <a href="http://github.com/demian0311/ruck/tree/master">ruck</a></div>
</div>
</body>
</html>
