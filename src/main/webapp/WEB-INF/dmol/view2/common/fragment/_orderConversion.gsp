<%@ page import="grails.util.Environment" %>
<g:set var="conversion_value" value="0" />
<g:if test="${Environment.current == Environment.PRODUCTION}"><g:set var="conversion_value" value="${orderInfo.totalAmount ? orderInfo.totalAmount.toLong() : '0'}" /></g:if>
<!-- Google Code for &#27880;&#25991;&#20214;&#25968; Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 986744968;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "gSqhCID-3gQQiJHC1gM";
var google_conversion_value = ${conversion_value};
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/986744968/?value=0&amp;label=gSqhCID-3gQQiJHC1gM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!-- Yahoo Code for &#27880;&#25991;&#20214;&#25968; Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var yahoo_conversion_id = 1000060572;
var yahoo_conversion_label = "UMT1CJ_OmwUQ8dvk1AM";
var yahoo_conversion_value = ${conversion_value};
/* ]]> */
</script>
<script type="text/javascript" src="https://s.yimg.jp/images/listing/tool/cv/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="https://b91.yahoo.co.jp/pagead/conversion/1000060572/?value=0&amp;label=UMT1CJ_OmwUQ8dvk1AM&amp;guid=ON&amp;script=0&amp;disvt=true"/>
</div>
</noscript>
