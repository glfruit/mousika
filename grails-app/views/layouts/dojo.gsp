<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:message code="default.app.title"/></title>
        <link rel="stylesheet"
              href="${resource(dir: 'js/dojo/1.8.3/dojo/resources', file: 'dojo.css')}"
              type="text.css"/>
        <link rel="stylesheet"
              href="${resource(dir: 'js/dojo/1.8.3/dijit/themes', file: 'dijit.css')}"
              type="text.css"/>
        <link rel="stylesheet"
              href="${resource(dir: 'js/dojo/1.8.3/dijit/themes/tundra', file: 'tundra.css')}"
              type="text.css"/>
        <dojo:header theme="tundra" showSpinner="true"
                     modulePaths="[bootstrap: 'dojo-bootstrap/1.2']"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap.css')}"
              type="text/css"/>
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"
              type="text.css"/>
        <dojo:require modules="['dijit.dijit', 'dijit.Calendar']"/>
        <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
        </style>
        <g:layoutHead/>
        <r:layoutResources/>
    </head>

    <body>

        <g:layoutBody/>
        <script>
            dojoConfig = {
                has: {
                    "dojo-firebug": true,
                    "dojo-debug-messages": true
                },
                async: true,
                parseOnLoad: false,
                locale: "zh-CN",
                require: ['dijit.dijit', 'dijit.Calendar'],
                modulePaths: {
                    "bootstrap": "dojo-bootstrap/1.2"
                }
            };
        </script>
        <script src="js/dojo/1.8.3/dojo/dojo.js"
                data-dojo-config="async: true"></script>
        <r:layoutResources/>
    </body>
</html>