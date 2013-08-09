
<%@ page import="com.sanwn.mousika.Teaching" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="system">
        <title><g:message code="user.list.label"/></title>
        <style type="text/css">
        ul{list-style:none;}
        li{list-style:none;}
        </style>
    </head>
	<body>
		<div id="list-teaching" class="content scaffold-list" role="main">
            <h4 style="border-bottom: 1px solid black;">授课情况</h4>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
					
						<th>课程名称</th>

                        <th>授课教师</th>

                        <th>课程容量</th>

                        <th>更新频次</th>

                        <th>作业次数</th>

                        <th>批改次数</th>

                        <th>使用时间</th>
					
						%{--<g:sortableColumn property="capability" title="课程容量" />
					
						<g:sortableColumn property="frequency" title="更新频次" />
					
						<g:sortableColumn property="assignmentTimes" title="作业次数" />
					
						<g:sortableColumn property="checkTimes" title="批改次数" />
					
						<g:sortableColumn property="time" title="使用时间" />--}%
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${teachingInstanceList}" status="i" var="teachingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: teachingInstance.course, field: "title")}</td>

                        <td>${fieldValue(bean: teachingInstance.course.deliveredBy, field: "fullname")}</td>
					
						<td>${fieldValue(bean: teachingInstance, field: "capability")}</td>
					
						<td>${fieldValue(bean: teachingInstance, field: "frequency")}</td>
					
						<td>${fieldValue(bean: teachingInstance, field: "assignmentTimes")}</td>
					
						<td>${fieldValue(bean: teachingInstance, field: "checkTimes")}</td>
					
						<td>${fieldValue(bean: teachingInstance, field: "time")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${teachingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
