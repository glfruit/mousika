<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="zh-CN" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="zh-CN" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="zh-CN" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="zh-CN" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="zh-CN" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:message code="default.app.title"/></title>
        <link rel="stylesheet"
              href="${resource(dir: 'js/lib/dijit/themes/tundra', file: 'tundra.css')}"
              type="text/css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap.css')}"
              type="text/css"/>
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"
              type="text.css"/>
        <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }

        .tundra table.dijitCalendarContainer {
            width: 300px;
            margin: 10px auto;
        }

        #formatted {
            text-align: center;
        }
        </style>
        <script type="text/javascript">
            dojoConfig = {
                tlmSiblingOfDojo: false,
                packages: [
                    {
                        name: 'bootstrap', location: "${request.contextPath}/js/lib/dojo-bootstrap"
                    }
                ],
                has: {
                    "dojo-firebug": true,
                    "dojo-debug-messages": true,
                    "config-tlmSiblingOfDojo": true
                },
                async: true,
                parseOnLoad: true,
                locale: 'zh'
            };
        </script>
        <script type="text/javascript"
                src="${resource(dir: 'js/lib/dojo', file: 'dojo.js')}"></script>
        <script type="text/javascript">
            require(['dojo/parser', 'dijit/dijit', 'dijit/Calendar', 'dijit/TitlePane']);
        </script>
    %{--<r:require module="ember"/>--}%
        <shiro:hasRole name="教师">
            <style type="text/css">
            #courseAdmin {
                display: none;
            }
            </style>
        </shiro:hasRole>
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
                    <a class="brand" href="${request.contextPath}"><g:message
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
                    <h4 style="border-bottom: 1px solid #000;color: #777777;">
                        <g:message code="label.app.menu.nav"/>
                    </h4>
                    <shiro:hasAnyRole in="[教师, 系统管理员, 课程负责人]">
                        <div>
                            <p id="courseAdminTitle" style="cursor: pointer;"><i
                                    id="titleIcon"
                                    class="icon-chevron-right"></i><span>课程管理</span>
                            </p>
                            <ul id="courseAdmin" style="list-style: none;">
                                <li><i class="icon-edit"></i>打开编辑</li>
                                <li><i class="icon-pencil"></i>编辑设置</li>
                                <li><i class="icon-user"></i>成员</li>
                                <li><i class="icon-list"></i> 成绩</li>
                                <li><i class="icon-arrow-up"></i> 导入</li>
                            </ul>
                        </div>
                        <script>
                            require(['dojo/on', 'dojo/dom', 'dojo/dom-style', 'dojo/dom-class'], function (on, dom, domStyle, domClass) {
                                on(dom.byId('courseAdminTitle'), "click", function () {
                                    if (domClass.contains("titleIcon", "icon-chevron-right")) {
                                        domClass.replace("titleIcon", "icon-chevron-down", "icon-chevron-right");
                                    } else {
                                        domClass.replace("titleIcon", "icon-chevron-right", "icon-chevron-down");
                                    }
                                    var display = domStyle.get(dom.byId('courseAdmin'), 'display');
                                    display = display == "none" ? "block" : "none";
                                    domStyle.set(dom.byId('courseAdmin'), 'display', display);
                                });
                            });
                        </script>
                    </shiro:hasAnyRole>
                </div>

                <div class="span7">
                    <g:layoutBody/>
                </div>

                <div class="span3" style="padding-top: 20px;">
                    <div id="tp2" data-dojo-type="dijit/TitlePane"
                         data-dojo-props="title: '新闻通知'"
                         style="padding-bottom: 10px;">
                        <p>新增课程《计算机网络基础》</p>

                        <p>《Java程序设计》课程授课地点更改通知</p>
                    </div>

                    <div>
                        <div data-dojo-type="dijit/Calendar">
                            <script type="dojo/method"
                                    data-dojo-event="onChange"
                                    data-dojo-args="value">
                                require(["dojo/dom", "dojo/date/locale","dojo/on"], function(dom, locale,on){
                                dom.byId('formatted').innerHTML = locale.format(value, {formatLength: 'full', selector:'date'});
                                });
                            </script>
                        </div>

                        <p id="formatted"></p>
                    </div>
                </div>
            </div>
            <hr>

            <footer>
                <p class="text-center">
                    <mousika:copyright/>
                </p>
            </footer>
        </div>
        <g:javascript library="application"/>
        <r:layoutResources/>
    </body>
</html>