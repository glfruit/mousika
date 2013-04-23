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
            <div class="message" role="status">${flash.message}</div>
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
        <g:each in="${0..<courseInstance?.numberOfWeeks+1}" var="n">
            <g:render template="section"
                      model="['startDate': courseInstance.startDate,
                              'section': courseInstance.sections[n], 'order': n]"/>
        </g:each>
        <script>
            require(['dojo/query', 'dojo/dnd/Source', 'dojox/form/Uploader', 'dojox/form/uploader/plugins/IFrame', 'bootstrap/Modal'], function (query) {
                query(".addContent").on('click', function (e) {
                    var csid = query(e.target).parent().attr('id');
                    csid = /csl(\d+)/.exec(csid)[1];
                    query('#sectionSeq').attr('value', csid);
                });
            });
        </script>
    </body>
</html>
