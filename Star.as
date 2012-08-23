package  {
	
	import StarShape;
	import com.greensock.*;
	import flash.display.*;
	import flash.events.Event;
	
	public class Star extends MovieClip {
		
		private var star:StarShape = new StarShape();
		private var config = {
			size : 10,
			width : 1.32,
			height : 4.4055,
			color : 0xFFFFFF,
			x : 0,
			y : 0,
			glowSize : 0,
			glowColor : 0xFFFFFF,
			trail : true
		}

		public function Star(customConfig) {
			customConfig = customConfig || {};
			
			updateConfig(customConfig);
			
			if(config.glowSize > 0){
				addGlow();
			}
			this.addChild(star);
			
			star.width = config.width * config.size;
			star.height = config.height * config.size;

			//this.addEventListener( Event.ADDED_TO_STAGE, addedToStage );
		}
		
		private function addedToStage(e=null){
			trace('Star instance added to stage');
		}
		
		public function getSize(){
			return config.size;
		}
		
		public function addGlow(){
			TweenMax.to(this, 0, {glowFilter:{color:config.glowColor, blurX:config.glowSize, blurY:config.glowSize, alpha:1}});
		}
		
		public function updateConfig(customConfig){
			for(var key in customConfig){
				if(config.hasOwnProperty(key) && customConfig.hasOwnProperty(key)){
					config[key] = customConfig[key];
				}
			}
		}

	}
	
}
