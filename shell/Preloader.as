package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import preloader.Background;
	import preloader.EndButton;
	import preloader.ProgressBar;
	
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	public class Preloader extends MovieClip
	{		
		private static const TIME_WORK_TIMER:Number = 3000;
		private static const COUNT_REPEATS_TIMER:int = 100;
		
		private var background:Background;
		private var button:EndButton;
		private var progressBar:ProgressBar;
		
		private var timer:Timer;
		private var remainRepeats:int;
		private var wait:Boolean = true;
		
		private var item:*;
		
		private var newContextMenu:ContextMenu;
		
		public function Preloader() 
		{
			
			this.newContextMenu = new ContextMenu();
			this.newContextMenu.hideBuiltInItems();
			this.contextMenu = this.newContextMenu;
			
			//=====================//автоматически сгенерировано
			if (stage) 
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.addEventListener(Event.ENTER_FRAME, this.checkFrame);
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progress);
			this.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			//=====================
			
			this.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
			
			if (stage) this.getFocus();
			else this.addEventListener(Event.ADDED_TO_STAGE, this.getFocus);
			
			this.timer = new Timer(Preloader.TIME_WORK_TIMER/Preloader.COUNT_REPEATS_TIMER, Preloader.COUNT_REPEATS_TIMER)
			this.remainRepeats = Preloader.COUNT_REPEATS_TIMER;
			this.timer.addEventListener(TimerEvent.TIMER, this.loading);
			this.timer.start();
			
			this.progressBar = new ProgressBar();
			this.addChild(this.progressBar);
			
			this.background = new Background();
			this.addChild(this.background);
			
			this.button = new EndButton();
			this.addChild(this.button);
			
			//("preloading started");
		}
		private function loading(event:TimerEvent):void		
		{
			this.progressBar.redraw((Preloader.COUNT_REPEATS_TIMER - this.remainRepeats) / Preloader.COUNT_REPEATS_TIMER);
			
			this.remainRepeats--;
			if (this.remainRepeats <= 0)
			{
				this.wait = false;
				this.loadingFinished();
			}
		}
		
		private function mouseClickHandler(event:MouseEvent):void
		{
			if (event.target == this.button)
			{
				this.wait = false;
				this.loadingFinished();
			}
			this.getFocus();
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.SPACE)
			{
				this.wait = false;
				this.loadingFinished();
			}
		}
		
		private function getFocus(event:Event = null):void
		{
			if (this.stage) this.stage.focus = this;
		}
		
		private function ioError(event:IOErrorEvent):void 
		{
			//(event.text);
		}
		
		private function progress(event:ProgressEvent):void 
		{
			// update loader
		}
		
		private function checkFrame(event:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				this.stop();
				if (!this.wait) this.loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			//=====================
			this.removeEventListener(Event.ENTER_FRAME, this.checkFrame);
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progress);
			this.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			//=====================
			
			// hide loader
			this.removeChild(this.background);
			this.removeChild(this.button);
			this.timer.removeEventListener(TimerEvent.TIMER, this.loading);
			this.removeEventListener(MouseEvent.CLICK, this.mouseClickHandler);
			this.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			this.removeEventListener(Event.ADDED_TO_STAGE, this.getFocus);
			
			this.startup();
		}
		
		private function startup():void 
		{
			this.nextFrame();
			
			var mainClass:Class = getDefinitionByName("Main") as Class;
			this.item = new mainClass();
			this.parent.addChildAt(this.item as DisplayObject, 0);
			
			this.parent.removeChild(this);
			
			
			if (this.item.stage) 
				this.item.initialize();
			else this.addEventListener(Event.ADDED_TO_STAGE, this.initialize, true);
		}
		
		private function initialize(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.initialize, true);
			
			this.item.initialize();
		}
	}
	
}