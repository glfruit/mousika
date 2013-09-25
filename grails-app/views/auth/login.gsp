<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course"/>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            <g:message code="label.course.list"/>
        </h4>

        <div id="publicCourseList">

        </div>
        <shiro:hasPermission permission="course:create">
            <g:link controller="course" action="create"
                    class="btn create"><g:message
                    code="course.create.label"/></g:link>
        </shiro:hasPermission>
        <shiro:isLoggedIn>
            <g:form style="float: right;" class="form-search"
                    url="[controller: 'course', action: 'search']" method='get'>
                <g:textField name="q" value="${params.q}" size="50"
                             class="input-medium search-query"/>
                <button type="submit" class="btn"><g:message
                        code="course.search.label"/></button>
            </g:form>
        </shiro:isLoggedIn>
    %{--<g:form url='[controller: "course", action: "search"]'--}%
    %{--id="searchableForm" name="searchableForm" method="get">--}%
    %{--<g:textField name="q" value="${params.q}" size="50"/> <input--}%
    %{--type="submit" value="Search"/>--}%
    %{--</g:form>--}%
        <script>
            require(['dojo/request', 'dojo/domReady!'], function (request) {
                request.get("${createLink(controller: 'course', action: 'listPublic')}", {
                    headers: {
                        'Accept': 'application/json'
                    }
                }).then(function (response) {
                            require(['dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query'],
                                    function (dom, domConstruct, arrayUtil, json, query) {
                                        var courses = json.parse(response);
                                        if (courses.length == 0) {
                                            domConstruct.create('p', {innerHTML: '暂时没有任何课程'}, query('#publicCourseList')[0]);
                                        } else {
                                            arrayUtil.forEach(courses, function (course) {
                                                var section = domConstruct.create('section', {
                                                    class: 'course-intro'
                                                }, query('#publicCourseList')[0]);
                                                var ul = domConstruct.create('ul', {class: 'thumbnails'}, section);
                                                var li = domConstruct.create('li', {class: 'span5'}, ul);
                                                var h3 = domConstruct.create('h3', null, li);
                                                domConstruct.create('a', {href: "${request.contextPath}/course/show/" + course.id, innerHTML: course.title}, h3);
                                                var teacher = course.teacher ? course.teacher : 'N/A';
                                                domConstruct.create('p', {innerHTML: '教师:' + teacher}, li);
                                                li = domConstruct.create('li', {class: 'span6', innerHTML: course.description}, ul);
                                            });
                                        }
                                    });
                        });
            });
        </script>
    </body>
</html>
