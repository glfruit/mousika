<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="system">
    <title><g:message code="privilege.list.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
    <g:javascript library="jquery" plugin="jquery"/>
    <script type="text/javascript">

        function chooseAll(item)
        {
            var inputs = document.getElementsByTagName("input");
            for (var i=0; i < inputs.length; i++)  //遍历页面上所有的 input
            {
                if (inputs[i].type == "checkbox")
                {
                    inputs[i].checked = item.checked;
                }
            }
        }
        function chooseChild(item)
        {
            var inputs =  document.getElementsByTagName("input");
            for (var inputsIndex=0; inputsIndex < inputs.length; inputsIndex++){
                if (inputs[inputsIndex].type == "checkbox" && inputs[inputsIndex].name.indexOf(item.id+":")==0 )
                {
                    inputs[inputsIndex].checked = item.checked;
                }
            }
        }
        function chooseParent(item)
        {
            var parent = item.parentNode.parentNode.parentNode.children[0];
            var parentChecked = false;
            for(var i=0;i<parent.parentElement.children[1].childElementCount;i++){
                //有一个子复选框被选，父复选框就被选
                if(parent.parentElement.children[1].children[i].children[0].checked){
                    parent.checked=true;
                    parentChecked = true;
                    break;
                }
            }
            if(!parentChecked){
                parent.checked = parentChecked;
            }
        }
    </script>
</head>

<body>
<div id="rolePermissions" name="rolePermissions" style="display: none"></div>
<div id="error" style="display: none"></div>

<div id="list-privilege" class="content scaffold-show" role="system">
    <h4 style="border-bottom: 1px solid black;"><g:message
            code="privilege.list.label"/></h4>
    <div class="container">
        <g:form action="save">
            <table>
                <tr>
                    <td width="7%">
                        <label class="control-label" for="role">角色</label>
                    </td>
                    <td width="93%">
                        <g:select style="width:150px;" name="role" id="role" from="${com.sanwn.mousika.Role.list([sort:"id"])}" value="${role.id}" optionKey="id" optionValue="name" onchange="${remoteFunction(action:'getRolePermission',onSuccess:"setCheckBox()",update:[success:'rolePermissions', failure:'error'], params: '\'role=\' + this.value')}"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <g:submitButton name="save" controller="privilege" action="save" value="保存"/>
                    </td>
                </tr>
                <tr>
                    <td width="7%">
                        <label class="control-label">权限</label>
                    </td>
                    <td width="93%">
                        <table id="privilegeTable" >
                            <g:if test="${privilegeResourceInstanceList}">
                            <g:each in="${privilegeResourceInstanceList}" var="privilegeResourceInstance" status="i">
                            <g:if test="${i==0}">
                            <tr>
                            </g:if>
                                <g:if test="${i<=7}">
                                <td style="vertical-align: top">
                                    <table class="table table-striped table-bordered table-condensed">
                                        <thead>
                                        <tr>
                                            <th>
                                                <input id="${privilegeResourceInstance.controllerEn}" type="checkbox" onclick='chooseChild(this)'> ${privilegeResourceInstance.controllerCn}
                                            </th>
                                        <tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${privilegeResourceInstance.privilegeResourceMethods}" var="privilegeResourceMethod">
                                            <tr>
                                                <td>
                                                    <input id="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" name="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" value="${privilegeResourceMethod.methodEn}"  type="checkbox" onclick="chooseParent(this)">${privilegeResourceMethod.methodCn}
                                                </td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </td>
                                </g:if>
                            <g:if test="${i==7}"> %{--如果小于7的时候会导致</tr>不能输出--}%
                            </tr>
                            </g:if>


                            <g:if test="${i==8}">
                            <tr>
                            </g:if>
                            <g:if test="${i<=15&&i>=8}">
                                <td style="vertical-align: top">
                                    <table class="table table-striped table-bordered table-condensed">
                                        <thead>
                                        <tr>
                                            <th>
                                                <input id="${privilegeResourceInstance.controllerEn}" type="checkbox" onclick='chooseChild(this)'> ${privilegeResourceInstance.controllerCn}
                                            </th>
                                        <tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${privilegeResourceInstance.privilegeResourceMethods}" var="privilegeResourceMethod">
                                            <tr>
                                                <td>
                                                    <input id="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" name="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" value="${privilegeResourceMethod.methodEn}"  type="checkbox" onclick="chooseParent(this)">${privilegeResourceMethod.methodCn}
                                                </td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </td>
                            </g:if>
                            <g:if test="${i==15}">
                            </tr>
                            </g:if>


                            <g:if test="${i==16}">
                                <tr>
                            </g:if>
                                <g:if test="${i<=23&&i>=16}">
                                    <td style="vertical-align: top">
                                        <table class="table table-striped table-bordered table-condensed">
                                            <thead>
                                            <tr>
                                                <th>
                                                    <input id="${privilegeResourceInstance.controllerEn}" type="checkbox" onclick='chooseChild(this)'> ${privilegeResourceInstance.controllerCn}
                                                </th>
                                            <tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${privilegeResourceInstance.privilegeResourceMethods}" var="privilegeResourceMethod">
                                                <tr>
                                                    <td>
                                                        <input id="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" name="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" value="${privilegeResourceMethod.methodEn}"  type="checkbox" onclick="chooseParent(this)">${privilegeResourceMethod.methodCn}
                                                    </td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>
                                    </td>
                                </g:if>
                                <g:if test="${i==23}">
                                    </tr>
                                </g:if>


                            </g:each>
                            </g:if>
                        </table>
                    </td>
                </tr>
            </table>
        </g:form>
    </div>
    %{--<g:each in="${grailsApplication.controllerClasses}" var="c">
    <li>
        <input id="${c.name.replace(c.name.charAt(0), c.name.charAt(0).toLowerCase())}" type="checkbox" onclick='chooseChild(this)'> ${c.name.replace(c.name.charAt(0), c.name.charAt(0).toLowerCase())}
        <ul>
            <%
                List<String> actions = new ArrayList<String>()
                actions = c.getURIs().collect({ uri ->
                    c.getMethodActionName(uri)
                }).unique().sort()
            %>
            <g:each in="${actions}" var="action">
                <li><input id="${c.name.replace(c.name.charAt(0), c.name.charAt(0).toLowerCase())}:${action}" name="${c.name.replace(c.name.charAt(0), c.name.charAt(0).toLowerCase())}:${action}" value="${action}"  type="checkbox" onclick="chooseParent(this)">${action}</li>
            </g:each>
        </ul>
    </li>
</g:each>--}%
    %{--<div class="container-fluid">
        <g:form action="save" >
            <fieldset class="buttons">
                <g:submitButton name="save" class="save" value="${message(code: 'privilege.save.label', default: 'Save')}" />
            </fieldset>
        --}%%{--<button class="btn" type="button" style="width:100px;" oncick="display()">保存</button>--}%%{--
        <div class="row-fluid">
            <div class="span4">
                <label>角色</label>
                <p>
                    <input id="role1" checked="checked" name="role" type="radio" value="1" onclick="${remoteFunction(action:'getRolePermission',update:[success:'rolePermissions', failure:'error'],onSuccess:"setCheckBox()", params:'\'role=\' + \'1\'')}"/>系统管理员
                </p>
                <p>
                    <input id="role2" name="role" type="radio" value="2" onClick="${remoteFunction(action:'getRolePermission',onSuccess:"setCheckBox()",update:[success:'rolePermissions', failure:'error'], params:'\'role=\' + \'2\'')}"/>教师
                </p>
                <p>
                    <input id="role3" name="role" type="radio" value="3" onclick="${remoteFunction(action:'getRolePermission',update:[success:'rolePermissions', failure:'error'],onSuccess:"setCheckBox()", params:'\'role=\' + \'3\'')}"/>课程负责人
                </p>
                <p>
                    <input id="role4" name="role" type="radio" value="4" onclick="${remoteFunction(action:'getRolePermission',update:[success:'rolePermissions', failure:'error'],onSuccess:"setCheckBox()", params:'\'role=\' + \'4\'')}"/>学生
                </p>
                <p>
                    <input id="role5" name="role" type="radio" value="5" onclick="${remoteFunction(action:'getRolePermission',update:[success:'rolePermissions', failure:'error'],onSuccess:"setCheckBox()", params:'\'role=\' + \'5\'')}"/>教务处
                </p>
            </div>
            <div class="span8">
                <ul id="actionTree">
                    <label>权限</label>
                    <li><input id="all" name="all" type="checkbox" value="*" onclick='chooseAll(this)'> 全选
                    <g:if test="${privilegeResourceInstanceList}">
                        <g:each in="${privilegeResourceInstanceList}" var="privilegeResourceInstance">
                            <li>
                                <input id="${privilegeResourceInstance.controllerEn}" type="checkbox" onclick='chooseChild(this)'> ${privilegeResourceInstance.controllerCn}
                                <ul>
                                    <g:each in="${privilegeResourceInstance.privilegeResourceMethods}" var="privilegeResourceMethod">
                                    <li><input id="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" name="${privilegeResourceInstance.controllerEn}:${privilegeResourceMethod.methodEn}" value="${privilegeResourceMethod.methodEn}"  type="checkbox" onclick="chooseParent(this)">${privilegeResourceMethod.methodCn}</li>
                                </g:each>
                                </ul>
                            </li>
                        </g:each>
                    </g:if>
                </ul>
            </div>
        </div>
        </g:form>
    </div>--}%
</div>
<script type="text/javascript">

    var permissions = "${permissions}";
    document.getElementById("role").value="${role.id}";
    initCheckBox(permissions)

    /*require(["dojo/query",
        "dojo/ready",
        "dojo/_base/event",
        "dojo/dom",
        "dojo/dom-class",
        "dojo/request",
        "dojo/dom-construct",
        "dojo/json",
        "dojo/_base/array",
        "bootstrap/Modal"], function (query, ready, event, dom, domClass, request, domConstruct, json, arrayUtil) {
        initPrivilegeTable();
        function initPrivilegeTable() {
            domConstruct.empty(dom.byId('privilegeTable'));
            request.get("${request.contextPath}/privilege/list", {
                headers: {
                    'Accept': 'application/json'
                }
            }).then(function (response) {
                  alert(json.parse(response));
            });
        }
    })*/

    function setCheckBox(){
        var div = document.getElementById("rolePermissions");
        permissions = div.innerHTML;
        alert(permissions)
        initCheckBox(permissions)
    }

    function initCheckBox(args){

        var permissions = args.replace("[","");
        permissions = permissions.replace("]","");

        var permissionsArray = permissions.split(", ");
        var controller;
        var methodAll;
        var inputs;

        //初始化为全未选
        inputs = document.getElementsByTagName("input");
        for(var inputsIndex=0; inputsIndex < inputs.length; inputsIndex++){
            if (inputs[inputsIndex].type == "checkbox")
            {
                inputs[inputsIndex].checked = false;
            }
        }

        for(var permissionsArrayIndex=0;permissionsArrayIndex<permissionsArray.length;permissionsArrayIndex++){
            controller = permissionsArray[permissionsArrayIndex].split(":")[0];
            methodAll = permissionsArray[permissionsArrayIndex].split(":")[1];
            //具有所有权限
            if(controller=="*"&&methodAll=="*"){
                inputs = document.getElementsByTagName("input");
                for(var inputsIndex=0; inputsIndex < inputs.length; inputsIndex++){
                    if (inputs[inputsIndex].type == "checkbox")
                    {
                        inputs[inputsIndex].checked = true;
                    }
                }
            } else if(methodAll=="*"){
                inputs =  document.getElementsByTagName("input");;
                for (var inputsIndex=0; inputsIndex < inputs.length; inputsIndex++){
                    if (inputs[inputsIndex].type == "checkbox" && inputs[inputsIndex].name.indexOf(controller+":")==0 )
                    {
                        inputs[inputsIndex].checked = true;
                    }
                }
            } else{
                var methodAllArray = methodAll.split(",");
                for(var methodAllArrayIndex=0;methodAllArrayIndex<methodAllArray.length;methodAllArrayIndex++){
                    inputs = document.getElementById(controller+":"+methodAllArray[methodAllArrayIndex]);
                    if (inputs!=undefined){
                        inputs.checked = true;
                    }
                }
            }
        }
    }
</script>
</body>
</html>
