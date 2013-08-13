<%@ page import="com.sanwn.mousika.Page" %>

<div class="control-group">
    <label class="control-label" for="title"><g:message
            code="page.title.label"/></label>

    <div class="controls">
        <g:textField name="title" maxlength="200" required=""
                     value="${pageInstance?.title}"/>
        <g:if test="${type == Date}">
            <div id="datePickerDiv" class="input-append date"
                 data-date-format="yyyy-mm-dd">
                <input type="text" name="${property}" value="${value}"
                       readonly="true"/>
                <span class="add-on"><i class="icon-th"></i></span>
            </div>
        %{--data-dojo-type="dijit/form/DateTextBox"/>--}%
        </g:if>
        <g:elseif test="${type == boolean || type == Boolean}">
            <g:checkBox name="${property}" value="${value}"/>
        </g:elseif>
        <g:elseif test="${type == String || type == int}">
            <g:textField name="${property}" value="${value}"/>
        </g:elseif>
    </div>
</div>

<div class="fieldcontain ${hasErrors(bean: pageInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="page.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" maxlength="200" required=""
                 value="${pageInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pageInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="page.description.label" default="Description"/>

    </label>
    <g:textArea name="description" value="${pageInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pageInstance, field: 'content', 'error')} required">
    <label for="content">
        <g:message code="page.content.label" default="Content"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="content" required="true"
                value="${pageInstance?.content}"/>
</div>

