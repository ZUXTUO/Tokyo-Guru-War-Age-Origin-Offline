var _____WB$wombat$assign$function_____ = function(name) {return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } }
{
  let window = _____WB$wombat$assign$function_____("window");
  let self = _____WB$wombat$assign$function_____("self");
  let document = _____WB$wombat$assign$function_____("document");
  let location = _____WB$wombat$assign$function_____("location");
  let top = _____WB$wombat$assign$function_____("top");
  let parent = _____WB$wombat$assign$function_____("parent");
  let frames = _____WB$wombat$assign$function_____("frames");
  let opener = _____WB$wombat$assign$function_____("opener");

"use strict";

var ds_share = {
	share_url: location.href,
	share_title: "东京战纪：软弱即是罪恶，走出你的强者之道！",
	share_pic: "/yy/mobile/images/share_icon.png",
	share_from: "软弱即是罪恶，走出你的强者之道！"
};

function share(type) {
	switch (type) {
		case 'wechat':
			var ua = window.navigator.userAgent.toLowerCase();
			if (ua.match(/MicroMessenger/i) == 'micromessenger') {
				$('.shareBox').fadeIn();
				$('.shareBox .tips-wechat').fadeIn();
			} else {
				$('.shareBox').css({ 'background-color': 'white' }).fadeIn();
				$('.shareBox .tips-normal').fadeIn();
			}
			break;
		case 'tqq':
			var param = {
				title: ds_share.share_title,
				site: ds_share.share_from,
				pic: ds_share.share_pic,
				url: ds_share.share_url
			};
			var temp = [];
			for (var p in param) {
				temp.push(p + '=' + encodeURIComponent(param[p] || ''));
			}
			window.open('');
			break;
		case 'qq':
			var param = {
				title: ds_share.share_title,
				site: ds_share.share_from,
				pics: ds_share.share_pic,
				url: ds_share.share_url
			};
			var temp = [];
			for (var p in param) {
				temp.push(p + '=' + encodeURIComponent(param[p] || ''));
			}
			window.open('');
			break;
		case 'weibo':
			var param = {
				url: ds_share.share_url,
				appkey: '',
				title: ds_share.share_title,
				pic: ds_share.share_pic,
				ralateUid: '',
				rnd: new Date().valueOf()
			};
			var temp = [];
			for (var p in param) {
				temp.push(p + '=' + encodeURIComponent(param[p] || ''));
			}
			window.open('');
			break;
		default:
			break;
	}
}

}
/*
     FILE ARCHIVED ON 01:38:12 Nov 08, 2019 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:39:50 Jan 04, 2021.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  RedisCDXSource: 2.564
  PetaboxLoader3.resolve: 42.694
  exclusion.robots.policy: 0.172
  exclusion.robots: 0.181
  captures_list: 146.182
  LoadShardBlock: 122.107 (3)
  PetaboxLoader3.datanode: 92.24 (4)
  esindex: 0.008
  CDXLines.iter: 18.273 (3)
  load_resource: 111.622
*/