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

var chaTop = $('#chracter').offset().top;
var newsTop = $('#gameNews').offset().top - 600;
var strTop = $('#gameStrategy').offset().top - 600;
var feaTop = $('#gameFeature').offset().top - 600;
var timer = null;
$('.toHeader').on('click', function () {
    $('body,html').animate({ scrollTop: 0 }, 600);
    $(window).off('scroll');
    if (timer !== null) {
        clearTimeout(timer);
    }
    timer = setTimeout(function () {
        $(window).on('scroll', toolBarScroll);
    }, 650);
    return false;
});
$('.toChracter').on('click', function () {
    $('body,html').animate({ scrollTop: chaTop }, 300);
    $(window).off('scroll');
    if (timer !== null) {
        clearTimeout(timer);
    }
    timer = setTimeout(function () {
        $(window).on('scroll', toolBarScroll);
    }, 350);
    return false;
});
$('.toGameNews').on('click', function () {
    $('body,html').animate({ scrollTop: newsTop + 120 }, 300);
    $(window).off('scroll');
    if (timer !== null) {
        clearTimeout(timer);
    }
    timer = setTimeout(function () {
        $(window).on('scroll', toolBarScroll);
    }, 350);
    return false;
});
$('.toGameStrategy').on('click', function () {
    $('body,html').animate({ scrollTop: strTop + 120 }, 300);
    $(window).off('scroll');
    if (timer !== null) {
        clearTimeout(timer);
    }
    timer = setTimeout(function () {
        $(window).on('scroll', toolBarScroll);
    }, 350);
    return false;
});
$('.toGameFeature').on('click', function () {
    $('body,html').animate({ scrollTop: feaTop + 120 }, 300);
    $(window).off('scroll');
    if (timer !== null) {
        clearTimeout(timer);
    }
    timer = setTimeout(function () {
        $(window).on('scroll', toolBarScroll);
    }, 350);
    return false;
});

//角色介绍
$(document).ready(function () {
    $(window).on('scroll', toolBarScroll);
});
var h = $(document).height() - $(window).height();
var p = 0,
    t = 0;
function toolBarScroll(tip) {
    if (tip == 'tap') {
        t = 0;
    }
    p = $(window).scrollTop();
    if (p >= 0 && p <= 2500) {
        if (p - t > 10 && p < h) {
            //下滚
            $('#nav').fadeOut();
        }
        if (t - p > 10 && p < h) {
            //上滚
            $('#nav').fadeIn();
        }
        setTimeout(function () {
            t = p;
        }, 0);
        if ($(document).scrollTop() >= h) {
            $('#nav').fadeIn();
        }
    }

    if (p > 2500) {
        $('#nav').fadeIn();
    }
}
//资讯
$('.listTitile').on('click', function (event) {
    var index = $(event.target).attr('news-data');
    switch (index) {
        case '0':
            targetTitle(event.target);$('.news_body').css('left', '0');break;
        case '1':
            targetTitle(event.target);$('.news_body').css('left', '-325px');break;
        case '2':
            targetTitle(event.target);$('.news_body').css('left', '-650px');break;
        case '3':
            targetTitle(event.target);$('.news_body').css('left', '-975px');break;
    }
});

function targetTitle(obj) {
    var liUniq = $('.listTitile li');
    for (var i = 0; i < liUniq.length; i++) {
        liUniq.eq(i).attr('class', 'block2');
    }
    $(obj).attr('class', 'block');
}

$('.strategyTitle').on('click', function (event) {
    var index = $(event.target).attr('strategy-data');
    switch (index) {
        case '0':
            targetTitle2(event.target);$('.strategy_listBox').css('left', '0');break;
        case '1':
            targetTitle2(event.target);$('.strategy_listBox').css('left', '-325px');break;
        case '2':
            targetTitle2(event.target);$('.strategy_listBox').css('left', '-650px');break;
        case '3':
            targetTitle2(event.target);$('.strategy_listBox').css('left', '-975px');break;
        case '4':
            targetTitle2(event.target);$('.strategy_listBox').css('left', '-1300px');break;
    }
});

function targetTitle2(obj) {
    var liUniq = $('.strategyTitle li');
    for (var i = 0; i < liUniq.length; i++) {
        liUniq.eq(i).attr('class', 'shape2');
    }
    $(obj).attr('class', 'shape');
}

var os = ''; //获取系统
var os2 = navigator.userAgent; //获取系统
$('.downloadAPP').on('click', function () {

    $.post(URL_DOWNLOAD_BY_PAGE, { page: 1, rows: 5 }, function (res) {
        var site = JSON.parse(res).data[0];
        var android_site = site.android_site;
        var ios_site = site.ios_site;
        if (!os2.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)) {
            //ios
            os = 'notIOS';
            window.location.href = '' + android_site + '';
        } else {
            os = 'IOS';
            // alert('iOS敬请期待')            
            window.location.href = '' + ios_site + '';
        }
    });
});

//播放PV
$('.play').on('click', function () {
    $('.pvPlayer').show();
    $.post(URL_VIDEO_BY_PAGE, { page: 1, rows: 1 }, function (res) {
        var data = JSON.parse(res).data;
        // console.log(data[0].mp4)
        $('.pvPlayer').html('<span class="closePV" style="color:#a40000">X</span> ');
        $('.pvPlayer').append(' <video controls="controls" style="width: 100%;margin-top: 50%" src="' + data[0].mp4 + '"></video>> ');
        closePV();
    });
});
function closePV() {
    $('.closePV').on('click', function () {
        $('.pvPlayer').hide();
        $('.pvPlayer').html('');
    });
}
$('.down').on('click', function () {
    $('.openWindow').slideDown(200);
    //阻止默认
    $("body").on("touchmove", function (event) {
        event.preventDefault;
    }, false);
});
$('.openWindow_close').on('click', function () {
    $('.openWindow').slideUp(200);
    $("body").off("touchmove");
});
$('.linkWX').on('click', function () {
    $('.contactWX').fadeIn();
});
$('.linkQQ').on('click', function () {
    $('.contactQQ').fadeIn();
});
$('.contact span').on('click', function () {
    $('.contact').fadeOut();
});

$('.share').on('click', function () {
    $('.shareWindow').fadeIn();
    $('body').attr('ontouchmove', 'return false;');
});

$('.tipClose').on('click', function () {
    $('.tip').fadeOut();
});
$('.tip2').on('click', function () {
    $('.tip2').fadeOut();
});
$('.shareWindow').on('click', function () {

    if ($(event.target).attr('class') == 'shareWindow') {
        $('.shareWindow').fadeOut();
        $('body').attr('ontouchmove', 'return true;');
    }
});
$('.shareToWX').on('click', function () {
    if ($(event.target).parent().attr('class') == 'shareToWX') {
        var ua = window.navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == 'micromessenger') {
            $('.tip2').fadeIn();
        } else {
            $('.tip').fadeIn();
        }
    }
});

}
/*
     FILE ARCHIVED ON 01:38:14 Nov 08, 2019 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:44:51 Jan 04, 2021.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 219.082
  PetaboxLoader3.resolve: 66.978
  LoadShardBlock: 163.205 (3)
  load_resource: 139.377
  PetaboxLoader3.datanode: 144.302 (4)
  exclusion.robots: 0.453
  esindex: 0.021
  CDXLines.iter: 43.351 (3)
  exclusion.robots.policy: 0.43
  RedisCDXSource: 6.276
*/