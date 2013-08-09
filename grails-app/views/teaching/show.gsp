
<%@ page import="com.sanwn.mousika.Teaching" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teaching.label', default: 'Teaching')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-teaching" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-teaching" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list teaching">
			
				<g:if test="${teachingInstance?.course}">
				<li class="fieldcontain">
					<span id="course-label" class="property-label"><g:message code="teaching.course.label" default="Course" /></span>
					
						<span class="property-value" aria-labelledby="course-label"><g:link controller="course" action="show" id="${teachingInstance?.course?.id}">${teachingInstance?.course?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${teachingInstance?.capability}">
				<li class="fieldcontain">
					<span id="capability-label" class="property-label"><g:message code="teaching.capability.label" default="Capability" /></span>
					
						<span class="property-value" aria-labelledby="capability-label"><g:fieldValue bean="${teachingInstance}" field="capability"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teachingInstance?.frequency}">
				<li class="fieldcontain">
					<span id="frequency-label" class="property-label"><g:message code="teaching.frequency.label" default="Frequency" /></span>
					
						<span class="property-value" aria-labelledby="frequency-label"><g:fieldValue bean="${teachingInstance}" field="frequency"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teachingInstance?.assignmentTimes}">
				<li class="fieldcontain">
					<span id="assignmentTimes-label" class="property-label"><g:message code="teaching.assignmentTimes.label" default="Assignment Times" /></span>
					
						<span class="property-value" aria-labelledby="assignmentTimes-label"><g:fieldValue bean="${teachingInstance}" field="assignmentTimes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teachingInstance?.checkTimes}">
				<li class="fieldcontain">
					<span id="checkTimes-label" class="property-label"><g:message code="teaching.checkTimes.label" default="Check Times" /></span>
					
						<span class="property-value" aria-labelledby="checkTimes-label"><g:fieldValue bean="${teachingInstance}" field="checkTimes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teachingInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="teaching.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:fieldValue bean="${teachingInstance}" field="time"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${teachingInstance?.id}" />
					<g:link class="edit" action="edit" id="${teachingInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
