<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
<head>
    <g:set var="entityName"
           value="${message(code: 'course.label')}"/>
    <title><g:message code="default.list.label"
                      args="[entityName]"/></title>
    <style type="text/css">
    .dojoxGridCell {
        font-size: 12px;
    }

    h2 {
        margin-top: 0;
    }
    </style>
    <link rel="stylesheet" href="/js/dojo-release-1.9.1/dojo/resources/dojo.css" />
    <link rel="stylesheet" href="/js/dojo-release-1.9.1/dijit/themes/claro/claro.css" />
    <link rel="stylesheet" href="/js/dojo-release-1.9.1/dojox/grid/resources/Grid.css" />
    <link rel="stylesheet" href="/js/dojo-release-1.9.11/dojox/grid/resources/claroGrid.css" />
    <!-- load dojo and provide config via data attribute -->
    <script src="/js/dojo-release-1.9.1/dojo/dojo.js"
            data-dojo-config="async: true, isDebug: true, parseOnLoad: true">
    </script>
    <script>
        var myStore, dataStore, grid;
        require([
            "dojo/store/JsonRest",
            "dojo/store/Memory",
            "dojo/store/Cache",
            "dojox/grid/DataGrid",
            "dojo/data/ObjectStore",
            "dojo/query",
            "dijit/form/Button"
        ],
                function (JsonRest, Memory, Cache, DataGrid, ObjectStore, query, Button) {
                    myStore = Cache(JsonRest({ target: "regCourse", idProperty: "id" }), Memory({ idProperty: "id" }));
                    grid = new DataGrid({
                        store: dataStore = ObjectStore({ objectStore: myStore }),
                        structure: [
                            { name: "名称", field: "title"},
                            { name: "代码", field: "code"},
                            { name: "授课周数", field: "numberOfWeeks"}
                        ]
                    }, "grid"); // make sure you have a target HTML element with this id

                    grid.startup();

//                    dojo.query("body").addClass("claro");

                    grid.canSort = function () { return false };
                });

    </script>
</head>

<body class="claro">
%{--<div style="height: 300px; width: 600px; margin: 10px;">--}%
    <div id="grid">
    </div>
%{--</div>--}%
</body>
</html>