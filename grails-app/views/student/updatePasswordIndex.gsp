
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="student">
    <title><g:message code="user.update.password"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
<body>
<div id="updatePassword-user" class="content scaffold-list" role="system">
    <h4 style="border-bottom: 1px solid black;">修改密码</h4>
    <g:if test="${flash.message}">
        <div class="message" role="error">${flash.message}</div>
    </g:if>
    <div class="container">
        <g:form action="updatePassword" class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="username">用户名</label>
                <div class="controls">
                    <label id="username" name="username"><shiro:principal/></label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="oldPassword">旧密码</label>
                <div class="controls">
                    <input type="password" id="oldPassword" name="oldPassword">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="newPassword1">新密码</label>
                <div class="controls">
                    <input type="password" id="newPassword1" name="newPassword1">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="newPassword2">新密码(再一次)</label>
                <div class="controls">
                    <input type="password" id="newPassword2" name="newPassword2">
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <fieldset class="buttons">
                        <g:submitButton name="updatePassword" action="updatePassword" value="更改" onclick="return checkForm()"/>
                    </fieldset>
                </div>
            </div>
        </g:form>
    </div>
</div>
<g:javascript>
    function checkForm(){
        if(document.getElementById("newPassword1").value==""){
            alert('密码不能为空');
            return false;
        }
        if(document.getElementById("newPassword2").value.value!=document.getElementById("newPassword1").value.value){
            alert('两次输入的密码不一致');
            return false;
        }else{
            return true;
        }
    }
</g:javascript>
</body>
</html>
