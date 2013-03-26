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
        <dojo:header theme="tundra" showSpinner="true"
                     modulePaths="[bootstrap: 'dojo-bootstrap/1.2']"/>
        <dojo:css file="dojo/resources/dnd.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap.css')}"
              type="text/css"/>
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"
              type="text.css"/>
        <dojo:require
                modules="['dijit.dijit', 'dijit.Calendar', 'dojo.dnd.Source', 'dijit.TitlePane']"/>
        <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
        </style>
        <g:layoutHead/>
        <r:layoutResources/>
    </head>

    <body class="tundra">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button type="button" class="btn btn-navbar"
                            data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#"><g:message
                            code="default.app.title"/></a>

                    <shiro:authenticated>
                        <div class="pull-right">
                            您好,<shiro:principal/><%=link(action: 'signOut', controller: 'auth') { '（注销）' }%>
                        </div>
                    </shiro:authenticated>
                    <shiro:notAuthenticated>
                        <g:form class="navbar-form pull-right"
                                controller="auth" action="signIn">
                            <input type="hidden" name="targetUri"
                                   value="${targetUri}"/>
                            <input class="span2" type="text"
                                   name="username" value="${username}"
                                   placeholder="<g:message
                                           code='label.login.username'/>">
                            <input class="span2" type="password"
                                   name="password" value=""
                                   placeholder="<g:message
                                           code='label.login.password'/>">
                            <button type="submit" class="btn"><g:message
                                    code="label.login"/></button>
                        </g:form>
                    </shiro:notAuthenticated>
                </div><!--/.nav-collapse -->
            </div>
        </div>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <h4 style="border-bottom: 1px solid #000;color: #777777;">新闻通知</h4>
                </div>

                <div class="span8">
                    <g:layoutBody/>
                </div>

                <div class="span2" style="padding-top: 20px;">
                    <div id="tp2" data-dojo-type="dijit.TitlePane"
                         data-dojo-props="title: '新闻通知'"
                         style="padding-bottom: 10px;">
                        Click arrow to close me.
                    </div>

                    <div class="pull-right" data-dojo-type="dijit.Calendar"
                         data-dojo-props="onChange:function(){dojo.byId('formatted').innerHTML=dojo.date.locale.format(arguments[0], {formatLength: 'full', selector:'date'})}"></div>

                    <p id="formatted"></p>
                </div>
            </div>
            <hr>

            <footer>
                <p class="text-center">&copy; <g:message
                        code="default.company.name"/> 2013</p>
            </footer>
        </div>

        <g:javascript library="application"/>
        <r:layoutResources/>
    </body>
</html>
