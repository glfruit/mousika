<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-3
  Time: 上午1:07
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="user">
    <title><g:message code="user.batch.import.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
<body>
<div class="sub">
    <h4 style="text-align: center;"><g:message
            code="user.batch.import.label"/></h4>
    <form  method="POST" action="batchImport" name="batchImport" id="batchImport" enctype="multipart/form-data">
        <dl class="addForm mT5">
            <dd>
                <table style="border:1">
                    <tr>
                        <td align="left">&nbsp;Excel文件：<input type="file" class="formFile" name="excelFile" ACCEPT= "application/x-msexcel"/></td>
                        %{--<td align="left"><input type=submit id="import" class="formBtn" value="导 入" onclick="if (!importTable()) return false;"/>
                        </td>--}%
                        <td>
                            <fieldset class="buttons">
                                <g:submitButton name="batchImport" class="batchImport" value="${message(code: 'user.batch.import.label', default: '导入')}" onclick="if (!importTable()) return false;"/>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </dd>
        </dl>
    </form>
</div>
<g:javascript>
    function importTable(){
        alert("aaa");
        var result = true;
        //var params = "recordId="+$("#recordId").val()+"&";
        $.ligerDialog.waitting("正在导入,请稍候...");

        $("form :input.notEmpty").each(function() {
            if(this.value.Trim()==""){
                $.ligerDialog.warn("必填项填写不正确！");
                result = false;
                return false;
            }
        });
        return result;
    }
</g:javascript>
</body>
</html>