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

'use strict';

!function () {
	document.write('<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" >');
	resize();

	window.onresize = function () {
		resize();
	};
}();

function resize() {
	var TARGET_WIDTH = 375;
	var scale = screen.width / TARGET_WIDTH;
	document.querySelector('meta[name="viewport"]').setAttribute('content', 'width=' + TARGET_WIDTH + ', initial-scale=' + scale + ', minimum-scale=' + scale + ', maximum-scale=' + scale + ', user-scalable=0');
}

}
/*
     FILE ARCHIVED ON 01:38:11 Nov 08, 2019 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:18:12 Jan 04, 2021.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  esindex: 0.015
  CDXLines.iter: 24.331 (3)
  exclusion.robots: 0.41
  PetaboxLoader3.resolve: 29.786
  PetaboxLoader3.datanode: 293.008 (4)
  captures_list: 391.727
  LoadShardBlock: 355.097 (3)
  exclusion.robots.policy: 0.393
  RedisCDXSource: 7.82
  load_resource: 73.023
*/