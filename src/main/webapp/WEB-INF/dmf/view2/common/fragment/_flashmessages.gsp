<g:if test="${flash.errormessage}">
<div class="errors flashmessages"><ul><li>${flash.errormessage?.encodeAsHTML()}</li></ul></div>
</g:if>
<g:elseif test="${flash.message}">
<div class="message flashmessages">${flash.message?.encodeAsHTML()}</div>
</g:elseif>