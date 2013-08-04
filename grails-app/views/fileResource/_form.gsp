<%@ page import="com.sanwn.mousika.CourseUnit; com.sanwn.mousika.FileResource" %>

<div class="fieldcontain ${hasErrors(bean: fileResourceInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="fileResource.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${fileResourceInstance?.title}"/>
</div>

