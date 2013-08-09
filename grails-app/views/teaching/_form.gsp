<%@ page import="com.sanwn.mousika.Teaching" %>



<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'course', 'error')} required">
	<label for="course">
		<g:message code="teaching.course.label" default="Course" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="course" name="course.id" from="${com.sanwn.mousika.Course.list()}" optionKey="id" required="" value="${teachingInstance?.course?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'capability', 'error')} ">
	<label for="capability">
		<g:message code="teaching.capability.label" default="Capability" />
		
	</label>
	<g:field name="capability" value="${fieldValue(bean: teachingInstance, field: 'capability')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'frequency', 'error')} ">
	<label for="frequency">
		<g:message code="teaching.frequency.label" default="Frequency" />
		
	</label>
	<g:field name="frequency" value="${fieldValue(bean: teachingInstance, field: 'frequency')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'assignmentTimes', 'error')} ">
	<label for="assignmentTimes">
		<g:message code="teaching.assignmentTimes.label" default="Assignment Times" />
		
	</label>
	<g:field name="assignmentTimes" type="number" value="${teachingInstance.assignmentTimes}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'checkTimes', 'error')} ">
	<label for="checkTimes">
		<g:message code="teaching.checkTimes.label" default="Check Times" />
		
	</label>
	<g:field name="checkTimes" type="number" value="${teachingInstance.checkTimes}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teachingInstance, field: 'time', 'error')} ">
	<label for="time">
		<g:message code="teaching.time.label" default="Time" />
		
	</label>
	<g:field name="time" value="${fieldValue(bean: teachingInstance, field: 'time')}"/>
</div>

