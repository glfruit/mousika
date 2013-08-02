<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="zh-CN" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="zh-CN" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="zh-CN" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="zh-CN" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="zh-CN" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle
            default="${message(code: 'default.app.title')}"/></title>
    <link rel="stylesheet"
          href="${resource(dir: 'js/lib/dijit/themes/tundra', file: 'tundra.css')}"
          type="text/css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'bootstrap.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'mousika.css')}"
          type="text/css"/>
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
                },
                {
                    name: 'jquery', location: "${request.contextPath}/js/lib/jquery", main: "jquery"
                },
                {
                    name: 'jplayer', location: "${request.contextPath}/js/jplayer", main: "jplayer"
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
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body class="tundra">
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <div class="row">
                    <div class="span4">
                        <a class="brand"
                           href="${request.contextPath}"><g:message
                                code="default.app.title"/></a>
                    </div>

                    <div class="span6" style="padding-top: 10px;">
                        <g:form class="form-search"
                                url="[controller: 'course', action: 'search']"
                                method='get'>
                            <g:hiddenField name="type" value="resource"/>
                            <g:textField name="q" value="${params.q}" size="50"
                                         class="input-xlarge search-query"/>
                            <button type="submit" class="btn"><g:message
                                    code="courseResource.search.label"/></button>
                        </g:form>
                    </div>

                    <div class="span2" style="padding-top: 10px;">
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
                    </div>
                </div>
            </div><!--/.nav-collapse -->
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span2">
                <div id="nav-panel"
                     data-dojo-type="dijit/TitlePane"
                     data-dojo-props="title: '导航'"
                     style="padding-bottom: 10px; padding-top: 20px;">
                    <ul style="list-style: none;text-align: left;margin: 0;padding: 0;">
                        <li>
                            <i class="icon-home"></i>
                            <span style="padding-left: 5px;">
                                <a href="${request.contextPath}">首页</a>
                            </span>
                        </li>
                        <li>
                            <i class="icon-book"></i>
                            <span style="padding-left: 5px;">
                                <a href="${createLink(controller: 'course', action: 'list')}">课程</a>
                            </span>
                        </li>
                    </ul>
                </div>
                <g:if test="${controllerName == 'course' && (actionName == 'show')}">
                    <shiro:hasAnyRole in="['教师', '系统管理员', '课程负责人']">
                        <div id="course-admin-panel"
                             data-dojo-type="dijit/TitlePane"
                             data-dojo-props="title: '课程管理'"
                             style="padding-bottom: 10px;">
                            <ul id="courseAdmin" style="list-style: none;">
                                <li><i class="icon-briefcase"></i><span
                                        style="padding-left: 5px;">
                                    <a href="${createLink(action: 'listMaterials', id: courseInstance.id)}">课程资料</a>
                                </span></li>
                                <li id="turn-edit-on-or-off"><i
                                        class="icon-edit"></i><a href="#"
                                                                 style="padding-left: 5px;"><span
                                            class="edit-course-region hide">打开编辑</span>
                                    <span class="edit-course-region">关闭编辑</span>
                                </a>
                                </li>
                                <li><i class="icon-pencil"></i><span
                                        style="padding-left: 5px;"><a
                                            href="${createLink(action: 'edit', id: courseInstance.id)}">编辑设置</a>
                                </span>
                                </li>
                                <li><i class="icon-user"></i><span
                                        style="padding-left: 5px;"><a
                                            href="${createLink(action: 'enrol', id: courseInstance.id)}">成员</a>
                                </span>
                                </li>
                                <li><i class="icon-list"></i><span
                                        style="padding-left: 5px;">成绩</span>
                                </li>
                            </ul>
                        </div>
                    </shiro:hasAnyRole>
                </g:if>
                <shiro:hasRole name="系统管理员">
                    <div data-dojo-type="dijit/TitlePane"
                         data-dojo-props="title: '系统管理'"
                         style="padding-bottom: 10px;">
                        <p><i class="icon-user"></i> <a
                                href="${createLink(controller: 'user', action: 'list')}">用户管理</a>
                        </p>
                    </div>
                </shiro:hasRole>
                <div data-dojo-type="dijit/TitlePane"
                     data-dojo-props="title: '我的个人文件'"
                     style="padding-bottom: 10px;">
                    <p>
                        <g:if test="${fileRepository?.items?.size() > 0}">
                            <!-- TODO -->
                        </g:if>
                        <g:else>
                            没有任何文件
                        </g:else>
                    </p>
                    <a class="btn"
                       href="${createLink(controller: 'fileRepository')}">管理我的个人文件</a>
                </div>
            </div>

            <div class="span7">
                <g:layoutBody/>
                <g:javascript library="application"/>
                <r:layoutResources/>

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
                            dom.byId('formatted').innerHTML = locale.format(value, {formatLength: 'full', selector:'date',locale:'zh'});
                            });
                        </script>
                    </div>

                    <p id="formatted"></p>
                </div>
            </div>
            <script>
                require(['dojo/query', 'dojo/dom-class'], function (query, domClass) {
                    query('#turn-edit-on-or-off').on('click', function () {
                        query(".edit-course-region").forEach(function (node) {
                            domClass.toggle(node, 'hide');
                        });
                    });
                });
            </script>
        </div>
        <hr>

        <footer>
            <p class="text-center">
                <mousika:copyright/>
            </p>
        </footer>
    </div>
</body>
</html>