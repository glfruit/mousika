
<%@ page import="com.sanwn.mousika.FileRepository" %>
<%@ taglib uri="http://ckfinder.com" prefix="ckfinder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fileRepository.label', default: 'FileRepository')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fileRepository" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fileRepository" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <ckfinder:ckfinder basePath="${resource(dir:'/ckfinder')}" />
            <table>
				<thead>
					<tr>
					
						<g:sortableColumn property="location" title="${message(code: 'fileRepository.location.label', default: 'Location')}" />
					
						<th><g:message code="fileRepository.owner.label" default="Owner" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fileRepositoryInstanceList}" status="i" var="fileRepositoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${fileRepositoryInstance.id}">${fieldValue(bean: fileRepositoryInstance, field: "location")}</g:link></td>
					
						<td>${fieldValue(bean: fileRepositoryInstance, field: "owner")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fileRepositoryInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
