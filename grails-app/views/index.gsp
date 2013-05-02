<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo"/>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            <g:message code="label.course.list"/>
        </h4>

        <div id="publicCourseList">

        </div>
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
                                                domConstruct.create('p', {innerHTML: '教师:' + course.teacher}, h3);
                                                li = domConstruct.create('li', {class: 'span6', innerHTML: course.description}, ul);
                                            });
                                        }
                                    });
                        });
            });
        </script>
    </body>
</html>
