<g:if test="${myCourses}">
    <g:each in="${myCourses}" status="i" var="course">
        <p>
            <g:link action="show" id="${course.id}"> ${course.title}</g:link>
        </p>

    </g:each>
</g:if>
<g:else>
    没有任何课程
</g:else>