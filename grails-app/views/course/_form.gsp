<%@ page import="com.sanwn.mousika.domain.Course" %>



<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'author', 'error')} ">
	<label for="author">
		<g:message code="course.author.label" default="Author" />
		
	</label>
	<g:textField name="author" value="${courseInstance?.author}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="course.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${courseInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'guestVisible', 'error')} ">
	<label for="guestVisible">
		<g:message code="course.guestVisible.label" default="Guest Visible" />
		
	</label>
	<g:checkBox name="guestVisible" value="${courseInstance?.guestVisible}" />
</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="course.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${courseInstance?.title}"/>
</div>

