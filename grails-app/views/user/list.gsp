
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="user">
    <title><g:message code="user.list.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
	<body>
		%{--<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>--}%

		<div id="list-user" class="content scaffold-list" role="main">
            <h1><g:message code="user.list.label" args="[entityName]" /></h1>
            <g:link class="create" action="create"><g:message code="user.create.label" args="[entityName]" /></g:link>&nbsp;&nbsp;&nbsp;&nbsp;<g:link class="batchImport" action="batchImport"><g:message code="user.batch.import.label" args="[entityName]" /></g:link></li>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
						<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: '用户名')}" />
					
						<g:sortableColumn property="fullname" title="${message(code: 'user.fullname.label', default: '姓名')}" />

						<g:sortableColumn property="firstAccessed" title="${message(code: 'user.firstAccessed.label', default: '首次访问时间')}" />

						<g:sortableColumn property="lastAccessed" title="${message(code: 'user.lastAccessed.label', default: '最后访问时间')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
					
						<td>${fieldValue(bean: userInstance, field: "fullname")}</td>

                        <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                          date="${userInstance.profile?.firstAccessed}"/></td>
                        <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                          date="${userInstance.profile?.lastAccessed}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
