<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="user">
    <title><g:message code="backup.list.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>

<body>

<div id="list-privilege" class="content scaffold-show" role="main">
    <h4 style="text-align: center;"><g:message  code="backup.list.label"/></h4>
    <div class="container">
        <p>
            <label>备份设置</label>
        </p>
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
        <p>
            <table>
                <tr>
                    <td>
                        <label>手动备份</label>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <g:link controller="backup" action="manualBackup" class="btn create">开始备份</g:link>
                    </td>
                </tr>
            </table>
        </p>
        <p>
        <table>
            <tr>
                <td>
                    <label>自动备份</label>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <g:link controller="backup" action="autoBackupStart" class="btn create">启动</g:link>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <g:link controller="backup" action="autoBackupStop" class="btn create">停止</g:link>
                </td>
            </tr>
        </table>
    </p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    </div>

</div>
</body>
</html>
