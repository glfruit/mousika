<!DOCTYPE HTML>

<!--[if lt IE 7 ]> <html lang="zh-CN" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="zh-CN" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="zh-CN" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="zh-CN" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="zh-CN" class="no-js"><!--<![endif]-->
<head>
    <g:javascript library="jquery" plugin="jquery"/>
    <script src="/js/jquery/jquery-1.9.1.min.js"></script>

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
                    <a class="brand" href="${request.contextPath}/student"><g:message
                            code="label.app.menu.nav"/></a>
                    %{--<g:link action="student"><g:message code="label.app.menu.nav"/></g:link>--}%
                </h4>
                <g:if test="${controllerName == 'student'}">
                    %{--actionName == 'list'--}%
                    <shiro:hasRole name="学生">
                        <div data-dojo-type="dijit/TitlePane"
                             data-dojo-props="title: '我的课程'"
                             style="padding-bottom: 10px;">
                            <div id="myCourseList"></div>
                            <script type="text/javascript">
                                jQuery(function(){
                                    $.ajax("/mousika/student/myCourseList",{
                                        type: "POST",
//                                        data: params,
                                        async:false,
                                        beforeSend: function(XMLHttpRequest){
                                            //ShowLoading();
                                        },
                                        success: function(data, textStatus){
                                            var myCourseList = (data);
                                            var linkList = "";
                                            if(myCourseList!=null)
                                            for(var i=0;i<myCourseList.length;i++){
                                                linkList = linkList+"<p><a href='show/"+(myCourseList[i].id)+"'>"+(myCourseList[i].title)+"</a></p>";
                                            }
                                            $("#myCourseList").html(linkList);
                                        },
                                        complete: function(XMLHttpRequest, textStatus){
                                            //HideLoading();
                                            //alert(12);
                                        },
                                        error: function(data){
                                            //请求出错处理
                                            //alert(13);
                                        }
                                    });
                                });
                            </script>

                            %{--<g:if test="${myCourses}">--}%
                                    %{--<g:each in="${myCourses}" status="i" var="course">--}%
                                        %{--<p>--}%
                                            %{--<g:link action="show" id="${course.id}"> ${course.title}</g:link>--}%
                                        %{--</p>--}%

                                    %{--</g:each>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                                %{--没有任何课程--}%
                            %{--</g:else>--}%
                        </div>
                        <div data-dojo-type="dijit/TitlePane"
                             data-dojo-props="title: '我的活动'"
                             style="padding-bottom: 10px;">
                            <p>
                                <g:link controller="student" action="regCourseList">注册课程</g:link>
                                <g:link controller="student" action="assignmentList">我的作业</g:link>
                            </p>
                            <p>
                                        我的提问与解答
                            </p>
                            <p>
                                <g:include view="shareto.gsp"></g:include>&nbsp;
                            </p>
                        </div>
                        <div data-dojo-type="dijit/TitlePane"
                             data-dojo-props="title: '个人信息'"
                             style="padding-bottom: 10px;">
                            <p>
                                <g:if test="${fileRepository?.items?.size() > 0}">
                                    <!-- TODO -->
                                </g:if>
                                <g:else>
                                    %{--没有任何文件--}%
                                </g:else>
                            </p>
                            %{--<a class="btn"  href="${createLink(controller: 'fileRepository')}">管理我的个人文件</a>--}%
                            <p>
                                <g:link controller="student" action="updateInformationIndex">编辑个人信息</g:link>
                            </p>
                            <P>
                            <g:link controller="student" action="updatePasswordIndex">更改密码</g:link>
                            </p>
                            <P>
                            <g:link controller="student" action="uploadPhotoIndex">上传头像</g:link>
                            </p>
                            <P>
                                <g:link controller="student" action="fileList">管理个人文件</g:link>
                            </p>
                            %{--<p>--}%
                                %{--<i class="icon-user"></i>--}%
                                %{--<a href="${createLink(controller: 'user', action: 'updateInformationIndex')}">编辑个人信息</a>--}%
                            %{--</p>--}%
                            %{--<p>--}%
                                %{--<i class="icon-lock"></i>--}%
                                %{--<a href="${createLink(controller: 'user', action: 'updatePasswordIndex')}">更改密码</a>--}%
                            %{--</p>--}%
                            %{--<p>--}%
                                %{--<i class="icon-picture"></i>--}%
                                %{--<a href="${createLink(controller: 'user', action: 'uploadPhotoIndex')}">上传头像</a>--}%
                        </div>
                    </shiro:hasRole>
                </g:if>
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