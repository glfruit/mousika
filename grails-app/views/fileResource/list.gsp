
<%@ page import="com.sanwn.mousika.FileResource" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fileResource.label', default: 'FileResource')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fileResource" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fileResource" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="fileResource.section.label" default="Section" /></th>
					
						<g:sortableColumn property="sequence" title="${message(code: 'fileResource.sequence.label', default: 'Sequence')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'fileResource.title.label', default: 'Title')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fileResourceInstanceList}" status="i" var="fileResourceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${fileResourceInstance.id}">${fieldValue(bean: fileResourceInstance, field: "section")}</g:link></td>
					
						<td>${fieldValue(bean: fileResourceInstance, field: "sequence")}</td>
					
						<td>${fieldValue(bean: fileResourceInstance, field: "title")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fileResourceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
