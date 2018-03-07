<g:if test="${false}">
/**
 * @param personalTitleId 敬称フォームのID/name
 * @param fromList 敬称の選択肢
 * @param personalTitleValue 現在の敬称
 */
</g:if>
<g:select id="${personalTitleId}" name="${personalTitleId}" from="${fromList}" optionKey="key" optionValue="value" value="${personalTitleValue ?: ''}" />