<%@ page import="com.sanwn.mousika.FileResource" %>



<div class="fieldcontain ${hasErrors(bean: fileResourceInstance, field: 'section', 'error')} required">
	<label for="section">
		<g:message code="fileResource.section.label" default="Section" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="section" name="section.id" from="${com.sanwn.mousika.domain.CourseSection.list()}" optionKey="id" required="" value="${fileResourceInstance?.section?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fileResourceInstance, field: 'sequence', 'error')} required">
	<label for="sequence">
		<g:message code="fileResource.sequence.label" default="Sequence" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="sequence" type="number" value="${fileResourceInstance.sequence}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: fileResourceInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="fileResource.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${fileResourceInstance?.title}"/>
</div>

