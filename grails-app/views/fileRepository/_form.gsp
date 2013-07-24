<%@ page import="com.sanwn.mousika.FileRepository" %>



<div class="fieldcontain ${hasErrors(bean: fileRepositoryInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="fileRepository.items.label" default="Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${fileRepositoryInstance?.items?}" var="i">
    <li><g:link controller="fileRepositoryItem" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="fileRepositoryItem" action="create" params="['fileRepository.id': fileRepositoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fileRepositoryItem.label', default: 'FileRepositoryItem')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: fileRepositoryInstance, field: 'location', 'error')} ">
	<label for="location">
		<g:message code="fileRepository.location.label" default="Location" />
		
	</label>
	<g:textField name="location" value="${fileRepositoryInstance?.location}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fileRepositoryInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="fileRepository.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${com.sanwn.mousika.User.list()}" optionKey="id" required="" value="${fileRepositoryInstance?.owner?.id}" class="many-to-one"/>
</div>

