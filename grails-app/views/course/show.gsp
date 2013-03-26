<%@ page import="com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
        <style>
        .commands {
            white-space: nowrap;
            display: inline;
        }
            li {
                cursor: text;
            }
        </style>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            ${fieldValue(bean: courseInstance, field: "title")}
        </h4>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div style="border: black solid 1px;">
            <ol data-dojo-type="dojo.dnd.Source" data-dojo-props="accept: ['item']" id="wishlistNode">
                <li class="dojoDndItem" dndType="item">Wrist watch</li>
                <li class="dojoDndItem" dndType="item">Life jacket</li>
                <li class="dojoDndItem" dndType="item">
                    <div style="float: left;padding-right: 10px;">
                        <a href="#">Docu</a>
                        <span>Doc Type</span>
                    </div>
                    <span class="commands">
                        <a href="#"><g:img file="editstring.svg"/></a>
                        <a href="#" style="cursor: move;"><g:img file="move_2d.svg"/> </a>
                        <a href="#"><g:img file="hide.svg"/></a>
                    </span>
                </li>
                <li class="dojoDndItem" dndType="item">Vintage microphone</li>
                <li class="dojoDndItem" dndType="item">TIE fighter</li>
            </ol>
        </div>

        <div style="height: 300px;">
            <ol data-dojo-type="dojo.dnd.Source"
                data-dojo-props="accept: ['item']"
                style="height:300px;border: 1px solid #aaa;">

            </ol>
        </div>
    </body>
</html>
