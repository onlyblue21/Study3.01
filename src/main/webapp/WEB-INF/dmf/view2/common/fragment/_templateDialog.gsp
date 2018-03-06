<!-- テンプレートライブラリダイアログ ==> -->
<div id="templateSelectDialog" title="テンプレート" style="display:none">
	<div class="dialoghead">
		<table class="templateDialogHeadTable">
			<tr>
				<td class="w500 align_left borderRight">
					<span>キーワード検索：</span>
					<input type="text" class="w320" id="templateSelectDialogKeyword" /> <button id="templateSelectDialogSearchBtn">検索</button>
				</td>
				<td class="cassetteDialogSmallCell on" id="templateSelectDialogLimitSizeCheckbox">
					<input type="checkbox" id="templateSelectDialogLimitSize" /> <label for="templateSelectDialogLimitSize">同じサイズのみ表示</label>
				</td>
			</tr>
		</table>
	</div>

	<div id="templateDialogMain" class="templateDialogMain">

		<!-- 左カラム -->
		<div id="templateDialogLeft" class="templateDialogLeft on">
			<div class="templateDialogLeftIn">

				<div class="folderMenu" id="folderArea">
				</div>

				<div class="lineW"></div>
				<p class="pL10">テンプレート数：<span id="templateNumber">0</span>
			</div>
		</div>
		<!-- /左カラム -->

		<!-- 右カラム -->
		<div class="templateDialogRight" id="templateListArea">
			<div class="paginationBlock" style="display:none">
				<div class="pagination">
					<ul>
						<li class="pp"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_pp.gif" /></a></li>
						<li class="p"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_p.gif" /></a></li>
						<li><span class="dispPage1"></span></li>
						<li><span class="dispPage2"></span></li>
						<li><span class="dispPage3"></span></li>
						<li class="n"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_n.gif" /></a></li>
						<li class="nn"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_nn.gif" /></a></li>
					</ul>
					<p class="dispPage">0-0 / 0</p>
					<div style="float:left;padding-left:10px">（<span id="maxSelector"></span> / page）</div>
				</div>
			</div>
			<div id="contentsList">
			</div>
			<div class="paginationBlock" style="display:none">
				<div class="pagination">
					<ul>
						<li class="pp"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_pp.gif" /></a></li>
						<li class="p"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_p.gif" /></a></li>
						<li><span class="dispPage1"></span></li>
						<li><span class="dispPage2"></span></li>
						<li><span class="dispPage3"></span></li>
						<li class="n"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_n.gif" /></a></li>
						<li class="nn"><a href="javaScript:void(0)"><img src="${resource(dir:'static/moon/images',file:'tool')}/btn_page_nn.gif" /></a></li>
					</ul>
					<p class="dispPage">0-0 / 0</p>
					<div style="float:left;padding-left:10px">（<span id="maxSelector"></span> / page）</div>
				</div>
			</div>
		</div>
		<!-- /右カラム -->
	</div>
</div>
<!-- <== テンプレートライブラリダイアログ -->
