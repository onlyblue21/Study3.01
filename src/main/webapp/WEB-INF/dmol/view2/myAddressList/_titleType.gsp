<g:if test="${false}">
/**
 * @param fromList 敬称の選択肢
 * @param titleType 現在の敬称
 */
</g:if>
<g:select id="titleType" name="titleType" from="${fromList}" optionKey="key" optionValue="value" value="${titleType ?: ''}" />