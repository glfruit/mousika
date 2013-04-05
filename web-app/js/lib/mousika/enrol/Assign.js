define(["dojo/query",
    "dojo/ready",
    "bootstrap/Modal"], function (query, ready) {
    ready(function () {
        query(".enrol").on("click", function (e) {
            require(['dojo/request', 'dojo/dom', 'dojo/dom-attr'], function (request, dom, domAttr) {
                request.post("${request.contextPath}/course/assign/${params.id}", {
                    data: {
                        uid: domAttr.get(query(e.target).siblings(".user-id")[0], "value"),
                        rid: dom.byId("roleList").value
                    }
                }).then(function (response) {
                        require(["dojo/json"], function (json) {
                            if (json.parse(response).success) {
                                query(e.target).parents("tr").first().addClass("success");
                                query(e.target).addClass("hide");
                            } else {
                                alert("failure!" + json.parse(response).error);
                            }
                        });
                    });
            });
        });
        query(".page-link").on("click", function (e) {  //TODO: 处理分页
            e.stopPropagation();
            e.preventDefault();
            require(['dojo/request', 'dojo/dom-attr'], function (request, domAttr) {
                var clz = query(e.target).parent().attr("class").toString();
                if (!clz.contains("active")) {
                    var p = query(e.target).attr("href").substring(1);
                    if (p == "back") {

                    } else if (p == "forward") {

                    } else {
                        p = parseInt(p);

                    }
                }
            });
        });
        query("#enrol-done").on("click", function () {
            require(['dojo/request'], function (request) {
                request.post("${request.contextPath}/course/listMembers/${params.id}").then(function (response) {
                    require(['dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json'], function (dom, domConstruct, arrayUtil, json) {
                        var tr = domConstruct.create('tr', null);
                        var users = json.parse(response);
                        arrayUtil.forEach(users, function (user) {
                            domConstruct.create("td", {innerHTML: user.fullname}, tr);
                            domConstruct.create("td", {innerHTML: user.email}, tr);
                            domConstruct.create("td", {innerHTML: user.lastAccessed}, tr);
                            domConstruct.create("td", {innerHTML: user.roles}, tr);
                        });
                    });
                });
            });
        });
    });
});