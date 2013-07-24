
<%@ page import="com.sanwn.mousika.FileRepository" %>
<%@ taglib uri="http://ckfinder.com" prefix="ckfinder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="course">
		<g:set var="entityName" value="${message(code: 'fileRepository.label', default: 'FileRepository')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-fileRepository" class="content scaffold-list" role="main">
            <h4>我的个人文件</h4>
            <hr/>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <ckfinder:ckfinder basePath="${resource(dir:'/ckfinder')}"  />
			<div class="pagination">
				<g:paginate total="${fileRepositoryInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
