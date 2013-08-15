<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: course?.id]"/>
        <title>创建新通知</title>
    </head>

    <body>
        <div id="create-notification" class="content scaffold-create"
             role="main">
<<<<<<< HEAD
            <ul class="breadcrumb" style="margin-top: 20px;">
                <li>
                    <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>
                    <span class="divider">/</span>
                </li>
                <li>
                    <a href="${createLink(controller: 'notification', action: 'list')}">课程通知</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    发布通知
                </li>
            </ul>
=======
            <g:if test="${course}">
                <ul class="breadcrumb" style="margin-top: 20px;">
                    <li>
                        <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>
                        <span class="divider">/</span>
                    </li>
                    <li>
                        <a href="${createLink(controller: 'notification', action: 'list')}">课程通知</a>
                        <span class="divider">/</span>
                    </li>
                    <li class="active">
                        发布通知
                    </li>
                </ul>
            </g:if>
            <g:else>
                <h3>发布通知</h3>
            </g:else>
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
            <g:if test="${flash.message}">
                <div class="message" role="status"
                     style="color: red;">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${notification}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${notification}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal"
                    style="margin-top: 10px;">
                <fieldset class="form">
                    <f:with bean="notification">
<<<<<<< HEAD
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${course?.id}"/>
=======
                        <g:if test="${course}">
                            <g:hiddenField name="courseId" id="courseId"
                                           value="${course?.id}"/>
                        </g:if>
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                        <f:field property="title" required="true"/>
                        <f:field property="content"/>
                        <div class="control-group">
                            <label class="control-label"
                                   for="notificationType">
                                通知类型
                            </label>

                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" name="notificationType"
<<<<<<< HEAD
                                           id="courseNotification" value="course"
=======
                                           id="courseNotification"
                                           value="course"
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                                           checked>
                                    课程通知
                                </label>
                                <label class="radio">
                                    <input type="radio" name="notificationType"
<<<<<<< HEAD
                                           id="publicNotification" value="public">
=======
                                           id="publicNotification"
                                           value="public">
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                                    公共通知
                                </label>
                            </div>
                        </div>
                    </f:with>
                </fieldset>
                <fieldset class="buttons" style="text-align: center;">
                    <g:submitButton id="createNotificationBtn"
                                    name="createNotificationBtn"
                                    class="btn btn-primary"
                                    value="发布"/>
                    <a class="btn"
<<<<<<< HEAD
                       href="${createLink(controller: 'course', action: 'show', id: course?.id)}">${message(code: 'default.cancel.label')}</a>
=======
                       href="${course ? createLink(controller: 'course', action: 'show', id: course?.id) : createLink(view: '/')}">${message(code: 'default.cancel.label')}</a>
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                </fieldset>
            </g:form>
            <script>
            </script>
        </div>
    </body>
</html>
