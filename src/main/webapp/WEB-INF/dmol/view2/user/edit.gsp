<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER">
<g:render template="/common/user/edit"/>
</sec:ifAllGranted>
<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER_SALES_BRANCH">
<g:render template="/common/user/editSalesBranch"/>
</sec:ifAllGranted>
