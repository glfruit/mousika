<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo"/>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            <g:message code="label.course.list"/>
        </h4>

        <p>暂时没有任何课程</p>
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
                                        arrayUtil.forEach(courses, function (course) {
                                            domConstruct.create('section', null, query('h4')[0], 'after');
                                        });
                                    });
                        });
            });
        </script>
    </body>
</html>
