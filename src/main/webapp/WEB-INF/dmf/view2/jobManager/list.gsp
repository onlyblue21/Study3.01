<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>JOB 管理画面</title>
<style type="text/css">
<!--
table#menu tbody tr td {
	padding: 4px;
}
.leftcol {
	width: 14em;
}
-->
</style>
</head>
<body>
	<div class="mainBlock">
		<h1>JOB List</h1>
<g:render template="/common/fragment/flashmessages" />
		<table  id="menu" class="results">
		    <thead>
		        <tr>
		            <g:sortableColumn property="job.name" title="Job Name"/>
		            <g:sortableColumn property="job.status" title="status"/>
		            <th>nextFireTime</th>
		            <th>Scheduler Operations</th>
		            <th>Job Operations</th>
		        </tr>
		    </thead>
		    <tbody>
		        <g:each in="${jobsList}" status="i" var="job">
		            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                <td>${job.group?.encodeAsHTML()}</td>
		                <td>${job.status?.encodeAsHTML()}</td>
		                <td>${job.nextFireTime?.encodeAsHTML()}</td>
		                <td>
		                    <g:link action="pause" params="['what':'JOB', 'jobName':job.name, 'jobGroup':job.group, 'triggerName':job.triggerName, 'triggerGroup':job.triggerGroup]"><img src="${createLinkTo(dir: 'images', file: 'skin/pause.png')}" border="0px" alt="Pause Job"></g:link>
		                    <g:link action="resume" params="['what':'JOB', 'jobName':job.name, 'jobGroup':job.group, 'triggerName':job.triggerName, 'triggerGroup':job.triggerGroup]"><img src="${createLinkTo(dir: 'images', file: 'skin/resume.png')}" border="0px" alt="Resume Job"></g:link>&nbsp;&nbsp;
		                </td>
		                <td>
		                    <a href="<g:createLink action="run" params="['what':'JOB', 'jobName':job.name, 'jobGroup':job.group, 'triggerName':job.triggerName, 'triggerGroup':job.triggerGroup]"></g:createLink>" class="button"><span class="nowrap">実行</span></a>
		                </td>
		            </tr>
		        </g:each>
		    </tbody>
		</table>
	</div>
<jq:jquery>
$("#menu tbody tr:visible").evenodd();
</jq:jquery>
</body>
</html>