
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
    <head>
        <meta name="layout" content="system">
        <title><g:message code="user.create.label"/></title>
        <style type="text/css">
        ul{list-style:none;}
        li{list-style:none;}
        </style>
    </head>
	<body>
        <div id="updateInformation-user" class="content scaffold-list" role="system">
            <h4 style="border-bottom: 1px solid black;">用户详细信息</h4>
            <g:if test="${flash.message}">
                <div class="message" role="error">${flash.message}</div>
            </g:if>
            <div class="container">
                <form class="form-horizontal" action="show">
                    <div class="control-group">
                        <label class="control-label" for="userPhoto">用户头像</label>
                        <div class="controls">
                            <img id="userPhoto" name="userPhoto" src="${createLink(controller: 'user', action: 'displayPhoto', id:"${userInstance.id}")}" width="100" height="100"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">用户名</label>
                        <div class="controls">
                            ${fieldValue(bean: userInstance, field: "username")}
                            %{--<input type="text" id="username" name="username"  value="${fieldValue(bean: userInstance, field: "username")}" disabled='disabled'>--}%
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">姓名</label>
                        <div class="controls">
                            ${fieldValue(bean: userInstance, field: "fullname")}
                            %{--<input type="text" id="fullname" name="fullname"  value="${fieldValue(bean: userInstance, field: "fullname")}" disabled='disabled'>--}%
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">角色</label>
                        <div class="controls">
                            %{--<input type="text" id="fullname" name="fullname"  value="${fieldValue(bean: userInstance, field: "fullname")}" disabled='disabled'>--}%
                            <g:each in="${userInstance.roles}" var="role">
                                ${role.name}；
                            </g:each>
                            %{--<g:select name="roles" from="${com.sanwn.mousika.Role.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.roles*.id}" class="many-to-many" disabled='disabled'/>--}%
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">email</label>
                        <div class="controls">
                            ${userInstance?.profile?.email}
                            %{--<input type="text" id="email" name="email"  value="${userInstance?.profile?.email}" disabled='disabled' />--}%
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="interests">兴趣</label>
                        <div class="controls">
                            <textarea rows="3" id="interests" name="interests" disabled='disabled'>${userInstance?.profile?.interests}</textarea>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="dateCreated">创建时间</label>
                        <div class="controls">
                            <label id="dateCreated"  name="dateCreated">
                                <g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${userInstance.dateCreated}"/>
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="firstAccessed">第一次访问时间</label>
                        <div class="controls">
                            <label id="firstAccessed"  name="firstAccessed">
                                <g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${userInstance?.profile?.firstAccessed}"/>
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="lastAccessed">最后一次访问时间</label>
                        <div class="controls">
                            <label id="lastAccessed"  name="lastAccessed">
                                <g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${userInstance?.profile?.lastAccessed}"/>
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <fieldset class="buttons">
                                <g:link name="back" class="btn list" action="list">返回</g:link>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </div>
		%{--<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>--}%
		%{--<div id="show-user" class="content scaffold-show" role="system">
			<h1><g:message code="user.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.fullname}">
				<li class="fieldcontain">
					<span id="fullname-label" class="property-label"><g:message code="user.fullname.label" default="Fullname" /></span>
					
						<span class="property-value" aria-labelledby="fullname-label"><g:fieldValue bean="${userInstance}" field="fullname"/></span>
					
				</li>
				</g:if>

               --}%%{-- <g:if test="${userInstance?.email}">
                    <li class="fieldcontain">
                        <span id="email-label" class="property-label"><g:message code="user.email.label" default="邮箱" /></span>

                        <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></span>

                    </li>
                </g:if>--}%%{--
			
				--}%%{--<g:if test="${userInstance?.profile}">
				<li class="fieldcontain">
					<span id="profile-label" class="property-label"><g:message code="user.profile.label" default="Profile" /></span>
					
						<span class="property-value" aria-labelledby="profile-label"><g:link controller="profile" action="show" id="${userInstance?.profile?.id}">${userInstance?.profile?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="user.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${userInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.passwordHash}">
				<li class="fieldcontain">
					<span id="passwordHash-label" class="property-label"><g:message code="user.passwordHash.label" default="Password Hash" /></span>
					
						<span class="property-value" aria-labelledby="passwordHash-label"><g:fieldValue bean="${userInstance}" field="passwordHash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.permissions}">
				<li class="fieldcontain">
					<span id="permissions-label" class="property-label"><g:message code="user.permissions.label" default="Permissions" /></span>
					
						<span class="property-value" aria-labelledby="permissions-label"><g:fieldValue bean="${userInstance}" field="permissions"/></span>
					
				</li>
				</g:if>--}%%{--
			
				<g:if test="${userInstance?.roles}">
				<li class="fieldcontain">
					<span id="roles-label" class="property-label"><g:message code="user.roles.label" default="Roles" /></span>
					
						<g:each in="${userInstance.roles}" var="r">
						<span class="property-value" aria-labelledby="roles-label"><g:link controller="role" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${userInstance?.id}" />
					<g:link class="edit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>--}%
	</body>
</html>
