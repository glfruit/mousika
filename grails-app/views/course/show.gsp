<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
        <style>
        .commands {
            white-space: nowrap;
            display: inline;
        }

        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            ${courseInstance?.title}
        </h4>
        <g:if test="${flash.message}">
            <div class="text-success" role="status">${flash.message}</div>
        </g:if>

        <div class="modal hide fade" id="addActivityOrResourceModal"
             tabindex="-1" role="dialog"
             aria-labelledby="activityOrResourceLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×</button>

                <h4 id="myModalLabel">添加活动或资源</h4>
            </div>

        <div class="modal-body">
            <g:form class="form-horizontal" action="addResource">
                <input type="hidden" id="sectionSeq" name="sectionSeq"/>
                <input type="hidden" id="courseId" name="courseId"
                       value="${courseInstance.id}"/>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="assignment" checked>作业<i
                        class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="quiz">测验<i class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="vocabulary">词汇表<i
                        class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="file">文件<i class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="page">页面<i class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="label">标签<i class="icon-question-sign"></i>
                </label>
                <label class="radio">
                    <input type="radio" name="itemContentType"
                           value="url">URL<i class="icon-question-sign"></i>
                </label>
                <!--
                    <form method="post" action="UploadFile.php" id="myForm"
                          enctype="multipart/form-data">
                        <input name="uploadedfile" multiple="true" type="file"
                               data-dojo-type="dojox.form.Uploader"
                               label="Select Some Files" id="uploader"/>
                        <input type="submit" label="Submit"
                               data-dojo-type="dijit.form.Button"/>
                    </form>
                    -->
                </div>

                <div class="modal-footer">
                    <g:submitButton name="addResourceBtn"
                                    class="btn btn-primary" value="添加"/>
                    <button id="add-done" class="btn" data-dismiss="modal"
                            aria-hidden="true">关闭</button>
                </div>
            </g:form>
        </div>
        <g:each in="${0..<courseInstance?.numberOfWeeks + 1}" var="n">
            <g:render template="section"
                      model="['startDate': courseInstance.startDate,
                              'section': courseInstance.sections[n], 'order': n]"/>
        </g:each>
        <script>
            require(['dojo/query', 'dojo/topic', 'dojo/request', 'dojo/dom-attr', 'dojo/dnd/Source', 'bootstrap/Modal', 'dojo/domReady!'],
                    function (query, topic, request, domAttr) {
                        query(".addContent").on('click', function (e) {
                            var csid = query(e.target).parent().attr('id');
                            csid = /csl(\d+)/.exec(csid)[1];
                            query('#sectionSeq').attr('value', csid);
                        });
                        topic.subscribe("/dnd/drop", function (source, nodes, copy, target) {
                            var current = target.current;
                            if (current != null) {
                                var clazz = domAttr.get(current, 'class');
                                console.log(clazz);
                            }
                            if (source == target) {
                                var node = nodes[0];
                                var nodeId = node.id.match(/.*(\d+)$/)[1];
                                var pos = current.id.match(/.*(\d+)$/)[1];
                                if (nodeId != pos) {
                                    var sectionSeq = source.id.match(/.*(\d+)$/)[1];
                                    require(['dojo/request'], function (request) {
                                        request.post("${request.contextPath}/courseSection/updateSeq",
                                                {
                                                    data: {
                                                        courseId: "${courseInstance.id}",
                                                        sourceSeq: sectionSeq,
                                                        internal: true,
                                                        oldPos: nodeId,
                                                        newPos: pos
                                                    }
                                                }).then(function (response) {
                                                    require(['dojo/json'], function (json) {
                                                        if (!json.parse(response).success) {
                                                            alert('更新失败！');
                                                        }
                                                    });
                                                });
                                    });
                                }
                            } else {
                                var nodeId = nodes[0].id.match(/.*(\d+)$/)[1], pos;
                                var sourceSectionSeq = source.id.match(/.*(\d+)$/)[1];
                                var targetSectionSeq = target.id.match(/.*(\d+)$/)[1];
                                if (current == null) {
                                    pos = target.getAllNodes().length;
                                } else {
                                    pos = current.id.match(/.*(\d+)$/)[1];
                                }
                                require(['dojo/request'], function (request) {
                                    request.post("${request.contextPath}/courseSection/updateSeq",
                                            {
                                                data: {
                                                    courseId: "${courseInstance.id}",
                                                    sourceSeq: sourceSectionSeq,
                                                    targetSeq: targetSectionSeq,
                                                    oldPos: nodeId,
                                                    newPos: pos
                                                }
                                            }).then(function (response) {
                                                require(['dojo/json'], function (json) {
                                                    if (!json.parse(response).success) {
                                                        alert('更新失败！'); //TODO: 1. 美化对话框； 2. 撤消拖动
                                                    }
                                                });
                                            });
                                });
                            }
                        });
                    });
        </script>
    </body>
</html>
