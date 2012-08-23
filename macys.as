import Star;
import com.greensock.*; 
import com.greensock.easing.*;
import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.external.ExternalInterface;
import flash.events.Event;
import flash.display.MovieClip;
import flash.display.LoaderInfo;

flash.system.Security.allowDomain("*");
flash.system.Security.allowInsecureDomain("*");


if(ExternalInterface.available){
	ExternalInterface.call('wpAd.overlay.exec');
} else{
	navigateToURL(new URLRequest('javascript:wpAd.overlay.exec()'), '_self');
}
var paramObj = LoaderInfo(root.loaderInfo).parameters,
		stageHeight:Number = 0,
		stageWidth:Number = 0,
		horseHeight:Number,
		clickThru:Sprite = new Sprite(),
		starConfig = {
			size : 20,
			color: 0xFFFFFF,
			glowColor : 0xFFFFFF,
			glowSize : 70
		},
		numStars = 8,
		stars = [],
		/*animConfig = [
			{ 
				x : stageWidth+20,
				delay : 0
			},
			{ 
				x : stageWidth/2+100,
				delay : 0.5
			},					
			{ 
				x : stageWidth/3,
				delay : 1
			},					
			{
				x : stageWidth-150,
				delay : 1.7
			},
			{
				x : stageWidth/1.5,
				delay : 2
			},
			{ 
				x : stageWidth/4,
				delay : 2.5
			}		
		],*/
		ribbonLeft:MovieClip = new MovieClip(),
		ribbonRight:MovieClip = new MovieClip(),
		bow:Bow = new Bow(),
		logo:Logo = new Logo(),
		deals_txt:Deals_txt = new Deals_txt(),
		txt_mask:Sprite = new Sprite(),
		ribbonTop:Number;

		
function init(){
	stage.scaleMode = StageScaleMode.NO_SCALE;
	stage.align = StageAlign.TOP_LEFT;
	setStageSize();
}

function exec(){
	buildStars();
	configStars();
	buildRibbon();
	addClickThru();
}

function buildStars(){
	var i = numStars,k=i;
	while(i--){
		starConfig.size = Math.floor(Math.random()*300) + 50;
		stars[i] = new Star( starConfig );
	}
}

function configStars(){
	if(stars.length > 0){
		var k, x = 0;
		for(k = 0; k < numStars; k++){
			
			var delaySecs = k/1.5;
			addChild(stars[k]);
			stars[k].x =  5 + Math.floor((Math.random() * (stageWidth-stars[k].width-5)));
			//stars[k].x = animConfig[k]['x'];
			stars[k].y = 0 - stars[k].height;
			x = x +stars[k].width + 10;			
			
			TweenLite.to(stars[k], 3, { delay : delaySecs /*animConfig[k]['delay']*/, y : stageHeight + 20 + stars[k].height, blurFilter:{blurX:5, blurY:5}, ease:Linear.easeNone })
		}
	}
}

function buildRibbon(){
	ribbonTop = (stageHeight/2) - 100;
	ribbonLeft.addChild(ribbonLeftSprite());
	ribbonRight.addChild(ribbonRightSprite());
	addChild(ribbonLeft);
	addChild(ribbonRight);
	ribbonLeft.y=ribbonRight.y=ribbonTop;
	ribbonLeft.x = 0 - ribbonLeft.width;
	ribbonRight.x = stageWidth;

	TweenLite.to(ribbonLeft, 0.7, { x : 0 })
	TweenLite.to(ribbonRight, 0.7, { x : (stageWidth/2)-40/*, onComplete : addBow*/ })
	addDeals_txt();
	setTimeout(addBow, 500);
}

function ribbonLeftSprite():Sprite{
	var r:Sprite = new Sprite();
	var w = stageWidth/2;
	r.graphics.beginFill(0xb81f26 ,1);
	//r.graphics.beginFill(0xE61E24)
	r.graphics.moveTo(0, 0);
	r.graphics.lineTo(w+40, 0);
	r.graphics.lineTo(w, 45);
	r.graphics.lineTo(w+40, 90);
	r.graphics.lineTo(0, 90);
	r.graphics.lineTo(0,0);
	r.graphics.endFill();
	return r;
}

function ribbonRightSprite():Sprite{
	var r:Sprite = new Sprite();
	var w = stageWidth/2;
	r.graphics.beginFill(0xb81f26 ,1);
	//r.graphics.beginFill(0xE61E24)
	r.graphics.moveTo(0, 0);
	r.graphics.lineTo(w+40, 0);
	r.graphics.lineTo(w+40, 90);
	r.graphics.lineTo(0, 90);
	r.graphics.lineTo(40, 45);
	r.graphics.lineTo(0,0);
	r.graphics.endFill();
	return r;
}

function addBow(){
	addChildAt(bow, numChildren-1);
	TweenLite.to(bow, 0, { scaleX : 2, scaleY : 2, x : stageWidth/2, y : ribbonTop + 45 })
	TweenLite.to(bow, 0.4, { scaleX : 0.4, scaleY : 0.4, onComplete : function(){addLogo();doSlide()} })
}

function addLogo(){
	addChild(logo);
	logo.x = 0-logo.width;
	logo.y=  ribbonTop+ 6;
}
function addDeals_txt(){
	addChild(deals_txt);
	deals_txt.x = (stageWidth/2) - (deals_txt.width / 2);
	deals_txt.y = 	ribbonTop + 26;
	txt_mask.graphics.lineStyle();
	txt_mask.graphics.beginFill(0xFFFFFF);
	txt_mask.graphics.drawRect(deals_txt.x,deals_txt.y,deals_txt.width,deals_txt.height);
	txt_mask.graphics.endFill();
	deals_txt.mask = txt_mask;
	deals_txt.x  = deals_txt.x - deals_txt.width;
}

function doSlide(){
	TweenLite.to(deals_txt, 0.4, { x : deals_txt.x + deals_txt.width });
	TweenLite.to(bow, 0.4, { x : stageWidth - bow.width  });
	TweenLite.to(logo, 0.4, { x : 50 });
}

function setStageSize(e:Event = null){
	if(e){ stage.removeEventListener( Event.RESIZE, setStageSize) }

	stageResize();

	if(stageHeight > 0 && stageWidth > 0){
		exec();
	}
	else{
		stage.addEventListener( Event.RESIZE, setStageSize);
	}
}

function stageResize(e = null){
	stageHeight = stage.stageHeight;
	stageWidth = stage.stageWidth;	
}

function addClickThru(){
	addChild(clickThru);
	clickThru.graphics.lineStyle();
	clickThru.graphics.beginFill(0xFFFFFF ,0);
	clickThru.graphics.drawRect(0,0,stageWidth,stageHeight);
	clickThru.graphics.endFill();
	clickThru.buttonMode = clickThru.useHandCursor = true;
	clickThru.addEventListener(MouseEvent.CLICK, (function(e:MouseEvent):void{ChangePage(root.loaderInfo.parameters.clickTag)}));
}

function ChangePage(url:*, window:String = "_blank"):void {
	var req:URLRequest = url is String ? new URLRequest(url) : url;
	if (!ExternalInterface.available) {
		navigateToURL(req, window);
	} else {
		var strUserAgent:String = String(ExternalInterface.call('function() {return navigator.userAgent;}')).toLowerCase();
		if (strUserAgent.indexOf("firefox") != -1 || (strUserAgent.indexOf("msie") != -1 && uint(strUserAgent.substr(strUserAgent.indexOf("msie") + 5, 3)) >= 6)) {
			ExternalInterface.call("window.open", req.url, window);
		} else {
			navigateToURL(req, window);
		}
	}
}

init();