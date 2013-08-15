<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="system">
    <title><g:message code="backup.list.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>

<body>

<div id="list-privilege" class="content scaffold-show" role="system">
    <h4 style="border-bottom: 1px solid black;"><g:message  code="backup.list.label"/></h4>
    <font color="red">在第一次运行手动备份和自动备份前请先进行备份设置，备份的数据库存放在教学经验分享系统的buckup目录下</font>
    </br>
    <table>
        <tr>
            <td>
                <label>备份设置</label>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <form class="form-horizontal" action="save">
                    <div class="control-group">
                        <label class="control-label" for="dataBasePath">数据库路径</label>
                        <div class="controls">
                            <input type="text" id="dataBasePath" name="dataBasePath"  value="${fieldValue(bean: backupInstance, field: "dataBasePath")}" onfocus="this.value=''" onblur="if(this.value==''){this.value='${fieldValue(bean: backupInstance, field: "dataBasePath")}'}">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="backupDelay">自动备份延迟(小时)</label>
                        <div class="controls">
                            <input type="text" id="backupDelay" name="backupDelay"  value="${fieldValue(bean: backupInstance, field: "backupDelay")}" onfocus="this.value=''" onblur="if(this.value==''){this.value='${fieldValue(bean: backupInstance, field: "backupDelay")}'}">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="autoBackupPeriod">自动备份周期(天)</label>
                        <div class="controls">
                            <input type="text" id="autoBackupPeriod" name="autoBackupPeriod"  value="${fieldValue(bean: backupInstance, field: "autoBackupPeriod")}" onfocus="this.value=''" onblur="if(this.value==''){this.value='${fieldValue(bean: backupInstance, field: "autoBackupPeriod")}'}">
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <fieldset class="buttons">
                                <g:submitButton name="save" class="save" value="${message(code: 'backup.save.label', default: '设置')}" />
                            </fieldset>
                        </div>
                    </div>
                </form>
            </td>
        <tr>
        <tr>
            <td>
                <label>手动备份</label>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <g:link controller="backup" action="manualBackup" class="btn create">开始备份</g:link>
            </td>
        </tr>
        <tr>
            <td>
                <label>自动备份</label>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <g:link controller="backup" action="autoBackupStart" class="btn create">启动</g:link>
                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                <g:link controller="backup" action="autoBackupStop" class="btn create">停止</g:link>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
