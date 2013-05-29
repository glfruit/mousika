<%@ page import="com.sanwn.mousika.domain.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.domain.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet"
              href="${resource(dir: 'js/lib/dojox/calendar/themes/tundra', file: 'Calendar.css')}"
              type="text/css"/>        <g:set var="entityName"
                                              value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">日程管理</h4>

        <div data-dojo-type="dojox/calendar/Calendar"
             data-dojo-props="dateInterval:'month'"
             class="span7"
             style="position:relative;width:700px;height:500px">
        </div>
        <script>
            require(["dojo/parser", "dojox/calendar/Calendar"]);
        </script>
    </body>
</html>
