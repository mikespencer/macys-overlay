package  {
	import flash.events.*;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.MovieClip;
	
	
	public class Overlay extends MovieClip {
		
		public var stageHeight:Number = 0;
		public var stageWidth:Number = 0;

		public function Overlay() {
			setFlexibleStage();
			this.addEventListener( Event.ADDED_TO_STAGE, setStageSize);
		}
		
		private function setFlexibleStage(){
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function setStageSize(e:Event = null){
			if(e){ stage.removeEventListener( Event.RESIZE, setStageSize) }
		
			stageResize();
		
			if(stageHeight > 0 && stageWidth > 0){
				exec();
			}
			else{
				stage.addEventListener( Event.RESIZE, setStageSize);
			}
		}
		
		private function stageResize(e = null){
			stageHeight = stage.stageHeight;
			stageWidth = stage.stageWidth;	
		}
		
		public function exec(){
			trace('exec called');
		}
	}
	
}
