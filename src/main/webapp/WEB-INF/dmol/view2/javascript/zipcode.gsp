function zipcodeToAddress(zipcode3Id, zipcode4Id, addressStateId, address1Id, address2Id, address3Id, address4Id) {
	if (!zipcode3Id || !zipcode4Id) {
		return false;
	}
	var zipcode = $("#" + zipcode3Id).val();
	var zipcode4 = $("#" + zipcode4Id).val();
	if (zipcode4) {
		zipcode += "" + zipcode4;
	}
	var lparams = {};
	lparams.zipcode = zipcode;
	$.ajax({
		url: "${createLink(controller:'zipcode', action:'toAddress')}",
		data: lparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "found") {
				var zinfo = data;
				if (zinfo.zipcode) {
					if (zinfo.zipcode.length > 3) {
						$("#" + zipcode3Id).val(zinfo.zipcode.substring(0,3));
						$("#" + zipcode4Id).val(zinfo.zipcode.substring(3));
					} else {
						$("#" + zipcode3Id).val(zinfo.zipcode);
					}
				}
				if (addressStateId) {
					$("#" + addressStateId).val(zinfo.addressState);
				}
				if (address3Id || address4Id) {
					if (address1Id) {
						$("#" + address1Id).val(zinfo.address1);
					}
					if (address2Id) {
						$("#" + address2Id).val(zinfo.address2);
					}
					if (address3Id) {
						$("#" + address3Id).val(zinfo.address3);
					}
					if (address4Id) {
						$("#" + address4Id).val(zinfo.address4);
					}
				} else {
					var address = '';
					if (address1Id) {
						if (zinfo.address1) {
							address += zinfo.address1;
						}
						if (zinfo.address2) {
							address += zinfo.address2;
						}
						$("#" + address1Id).val(address);
					}
					if (address2Id) {
						address = '';
						if (zinfo.address3) {
							address += zinfo.address3;
						}
						if (zinfo.address4) {
							address += zinfo.address4;
						}
						$("#" + address2Id).val(address);
					}
				}
			} else {
				$().toastmessage('showWarningToast', "住所が見つかりませんでした。");
//				var message = "住所が見つかりませんでした。";
//				oiyAlert(message);
			}
			return false;
		}
	});
	return false;
}