<%@ page import="com.sanwn.mousika.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" maxlength="20" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'fullname', 'error')} required">
	<label for="fullname">
		<g:message code="user.fullname.label" default="Fullname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fullname" required="" value="${userInstance?.fullname}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')}">
    <label for="email">
        <g:message code="user.email.label" default="邮箱" />
    </label>
    <g:textField name="email" required="" value="${userInstance?.email}"/>
</div>

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'profile', 'error')} ">
	<label for="profile">
		<g:message code="user.profile.label" default="Profile" />
		
	</label>
	<g:select id="profile" name="profile.id" from="${com.sanwn.mousika.Profile.list()}" optionKey="id" value="${userInstance?.profile?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordHash', 'error')} ">
	<label for="passwordHash">
		<g:message code="user.passwordHash.label" default="Password Hash" />
		
	</label>
	<g:textField name="passwordHash" value="${userInstance?.passwordHash}"/>
</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'permissions', 'error')} ">
	<label for="permissions">
		<g:message code="user.permissions.label" default="Permissions" />
		
	</label>
	
</div>--}%

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'roles', 'error')} ">
	<label for="roles">
		<g:message code="user.roles.label" default="Roles" />
		
	</label>
	<g:select name="roles" from="${com.sanwn.mousika.Role.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.roles*.id}" class="many-to-many"/>
</div>

