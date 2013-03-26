<%@ page import="com.sanwn.mousika.domain.Course" %>

<div class="control-group">
    <label class="control-label" for="author"><g:message
            code="course.code.label" default="Code"/></label>

    <div class="controls">
        <g:textField name="code" value="${courseInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="author"><g:message
            code="course.title.label" default="Title"/></label>

    <div class="controls">
        <g:textField name="title" value="${courseInstance?.title}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="description">
        <g:message code="course.description.label" default="Description"/>
    </label>

    <div class="controls">
        <g:textArea name="description" value="${courseInstance?.description}" />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="author"><g:message
            code="course.author.label" default="Author"/></label>

    <div class="controls">
        <g:textField name="author" value="${courseInstance?.author}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="startDate"><g:message
            code="course.startDate.label" default="Start Date"/></label>

    <div class="controls">
        <dojo:datePicker name="startDate" value="${courseInstance?.startDate}"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="guestVisible">
        <g:message code="course.guestVisible.label" default="Guest Visible"/>
    </label>

    <div class="controls">
        <g:checkBox name="guestVisible"
                    value="${courseInstance?.guestVisible}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="numberOfWeeks">
        <g:message code="course.numberOfWeeks.label" default="Number of Weeks"/>
    </label>

    <div class="controls">
        <g:select name="numberOfWeeks" from="${0..51}"
                  value="${courseInstance?.numberOfWeeks}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="timesPerWeek">
        <g:message code="course.timesPerWeek.label" default="Times per Week"/>
    </label>

    <div class="controls">
        <g:select name="timesPerWeek" from="${1..5}"
                  value="${courseInstance?.timesPerWeek}"/>
    </div>
</div>

<div class="control-group pagination-centered">
    <g:submitButton name="create"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</div>


