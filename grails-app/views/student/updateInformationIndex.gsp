
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="student">
    <title><g:message code="user.edit.information"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
<body>
<div id="updateInformation-user" class="content scaffold-list" role="system">
    <h4 style="border-bottom: 1px solid black;">编辑个人信息</h4>
    <g:if test="${flash.message}">
        <div class="message" role="error">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${userInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${userInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <div class="container">
        <form class="form-horizontal" action="updateInformation">
            <div class="control-group">
                <label class="control-label" for="username">用户名</label>
                <div class="controls">
                    <input type="text" id="username" name="username"  value="${fieldValue(bean: userInstance, field: "username")}" disabled='disabled'>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="fullname">姓名</label>
                <div class="controls">
                    <input type="text" id="fullname" name="fullname"  value="${fieldValue(bean: userInstance, field: "fullname")}" disabled='disabled'>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="roles">角色</label>
                <div class="controls">
                    <g:select name="roles" from="${com.sanwn.mousika.Role.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.roles*.id}" class="many-to-many" disabled='disabled'/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="email">email</label>
                <div class="controls">
                    <input type="text" id="email" name="email"  value="${userInstance?.profile?.email}">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="interests">兴趣</label>
                <div class="controls">
                    <textarea rows="3" id="interests" name="interests"  value="${userInstance?.profile?.interests}">${userInstance?.profile?.interests}</textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="dateCreated">创建日期</label>
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
                        <g:submitButton name="updateInformation" class="button" value="更新" />
                    </fieldset>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>