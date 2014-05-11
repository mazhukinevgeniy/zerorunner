package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;
	import native_controls.ProgressBar;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	public class Preloader extends MovieClip
	{
		private var progressBar:ProgressBar;
		
		private var entrancePoint:*;
		
		public function Preloader() 
		{
			super();
			
			
			if (stage)
				this.startInitialization();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, this.startInitialization);
			
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progress);
			this.loaderInfo.addEventListener(Event.COMPLETE, this.loadingFinished);
			
			this.graphics.beginFill(0x666666);
			this.graphics.drawRect(0, 0, 640, 480);
			this.graphics.endFill();
			
			this.progressBar = new ProgressBar();
			this.addChild(this.progressBar);
		}
		
		private function startInitialization(event:Event = null):void
		{
			if (event)
				this.removeEventListener(Event.ADDED_TO_STAGE, this.startInitialization);
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			this.stage.focus = this;
			
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
		}
		
		private function progress(event:ProgressEvent):void 
		{
			this.progressBar.redraw(event.bytesLoaded / event.bytesTotal);
		}
		
		private function loadingFinished(event:Event):void 
		{
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progress);
			this.loaderInfo.removeEventListener(Event.COMPLETE, this.loadingFinished);
			
			this.startup();
		}
		
		private function startup():void 
		{
			this.nextFrame();
			
			var mainClass:Class = getDefinitionByName("Main") as Class;
			this.entrancePoint = new mainClass();
			this.parent.addChildAt(this.entrancePoint as DisplayObject, 0);
			
			this.parent.removeChild(this);
		}
	}
	
}