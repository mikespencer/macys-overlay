/*global $, ActiveXObject*/
var wpAd = window.wpAd || {};
(function(win, doc, wpAd){

  'use strict';

  //in case the current page doesn't have jQuery on it already:
  if(!win.jQuery){
    var s = doc.createElement('script');
    s.type = 'text/javascript';
    s.src='http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js';
    doc.getElementsByTagName('head')[0].appendChild(s);
  }

  wpAd.overlay = wpAd.overlay || {};

  wpAd.overlay.isOpen = false;
  wpAd.overlay.window = {};

  wpAd.overlay.thisMovie = function(movieName){
    if (navigator.appName.indexOf("Microsoft") != -1) {
      return win[movieName];
    } else {
      return doc[movieName];
    }
  };

  wpAd.overlay.remove = function(){
    if(wpAd.overlay.isOpen){
      clearTimeout(wpAd.overlay.timer);
      wpAd.overlay.isOpen = false;
      $('#ad_overlay_bg').fadeOut(wpAd.overlay.fade_speed, function(){
        $(this).parent().remove();
      });
      $('#ad_overlay,  #ad_overlay_close').hide();
    }
  };

  wpAd.overlay.addSwf = function(){
    var $window = $(win),
            swf = 'http://www.washingtonpost.com/wp-adv/advertisers/macys/2011/overlay/macys.swf?clickTag=' + wpAd.overlay.ct,
            creative_code;

    wpAd.overlay.isOpen = true;      
    wpAd.overlay.window.width = $window.width();
    wpAd.overlay.window.height = $window.height();
    creative_code = '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="'+wpAd.overlay.window.width+'" height="'+wpAd.overlay.window.height+'" name="overlay_swf" id="overlay_swf" align="middle">' +
      '<param name="movie" value="'+swf+'" />' +
      '<param name="quality" value="high" />' +
      '<param name="bgcolor" value="#ffffff" />' +
      '<param name="play" value="true" />' +
      '<param name="wmode" value="transparent" />' +
      '<param name="scale" value="noscale" />' +
      '<param name="menu" value="true" />' +
      '<param name="devicefont" value="false" />' +
      '<param name="allowScriptAccess" value="always" />' +
      '<!--[if !IE]>-->' +
      '<object type="application/x-shockwave-flash" data="'+swf+'" width="'+wpAd.overlay.window.width+'" height="'+wpAd.overlay.window.height+'">' +
        '<param name="movie" value="'+swf+'" />' +
        '<param name="quality" value="high" />' +
        '<param name="bgcolor" value="#ffffff" />' +
        '<param name="play" value="true" />' +
        '<param name="wmode" value="transparent" />' +
        '<param name="scale" value="noscale" />' +
        '<param name="menu" value="true" />' +
        '<param name="devicefont" value="false" />' +
        '<param name="allowScriptAccess" value="always" />' +
      '</object>' +
      '<!--<![endif]-->' +
    '</object>';
    
    $('body').append('<div id="overlay_wrapper"><div id="ad_overlay">'+creative_code+'</div><div id="ad_overlay_bg" style="display:none;"></div><div id="ad_overlay_close"><img src="http://img.wpdigital.net/wp-adv/advertisers/mdrenfest/2011/close.png" height="32" width="70" style="border:0;" alt="Close" /></div></div>');

  };

  //This function is called via external interface once swf has loaded
  wpAd.overlay.exec = function(){
    var $window = $(win),
        $close = $('#ad_overlay_close'),
        leftPos = $window.scrollLeft();
      
    $('#ad_overlay_close, #ad_overlay_bg, #ad_overlay').css({top:$window.scrollTop()+'px', left : leftPos + 'px'});
    
    $('#ad_overlay_bg').css({opacity:wpAd.overlay.bg_opacity, height: $window.height() + 'px'}).fadeIn(wpAd.overlay.fade_speed, function(){
      $('#ad_overlay').css({'display' : 'block'});
      $close.css({left : ((wpAd.overlay.window.width + leftPos) - $close.outerWidth())+'px', display : 'block'}).click(wpAd.overlay.remove);
      wpAd.overlay.timer = setTimeout(wpAd.overlay.remove, 7000);
    });
  };

  wpAd.overlay.flashDetect = function() {
    var i,a,o,p,s="Shockwave",f="Flash",t=" 2.0",u=s+" "+f,v=s+f+".",rSW=new RegExp("^"+u+" (\\d+)");
    if((o=navigator.plugins)&&(p=o[u]||o[u+t])&&(a=p.description.match(rSW)))return a[1];
    else if(!!(win.ActiveXObject))for(i=10;i>0;i--)try{if(!!(new ActiveXObject(v+v+i)))return i;}catch(e){}
    return 0;
  };

  wpAd.overlay.init = function(){
    if(win.jQuery){
      $(function(){
        if(wpAd.overlay.flashDetect() >= 9){
          //performance issues fix for IE:
          if($.browser.msie){
            wpAd.overlay.fade_speed = 0;
            if($.browser.version <= 7){
              $(win).load(wpAd.overlay.addSwf);
            } else{
              wpAd.overlay.addSwf();
            }
          } else{
            wpAd.overlay.addSwf();
          }
        }
      });
    } else{
      setTimeout(wpAd.overlay.init,500);
    }
  };

  wpAd.overlay.init();

})(window, document, wpAd);