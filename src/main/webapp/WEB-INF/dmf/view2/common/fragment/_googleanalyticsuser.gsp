<%-- GoogleAnalyticsタグ出力Flagment
→GA廃止、GTM採用により GoogleTagManagerタグ出力Flagment

対象：ユーザー系
Envによって出力タグ切り替えを行う
 --%>
<!-- Google Tag Manager --><g:if env="production">
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KK7D98"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-KK7D98');</script>
</g:if><g:elseif env="test">
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-K4SMKV"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-K4SMKV');</script>
</g:elseif><g:else>
<!-- 開発環境の為GTMタグの出力を抑制しています。本来はここに <noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KK7D・・・ のタグが出力されます --></g:else>
<!-- End Google Tag Manager -->