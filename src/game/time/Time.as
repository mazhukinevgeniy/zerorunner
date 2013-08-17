package game.time 
{
	import game.utils.GameFoundations;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Time
	{
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		public static const aftertick:String = "aftertick";
		
		public static const setPause:String = "setPause";
		
		
		private var FPS:int;
		private var tickFrame:int;
		private var redrawFrame:int;
		
		private var cachers:Vector.<Vector.<ICacher>>;
		private var numberOfCachers:int;
		
		private var frameCount:int;
		
		public static const addCacher:String = "addCacher";
		
		private static var TBT:Number;
		public static function get TIME_BETWEEN_TICKS():Number
		{
			return Time.TBT;
		}
		
		
		private var fixed:Boolean = true;
		private var gameJuggler:Juggler;
		
		private var updateFlow:IUpdateDispatcher;
		
		public function Time(root:Sprite, foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			new PauseTypes(flow);
			
			this.FPS = Starling.current.nativeStage.frameRate;
			this.tickFrame = this.FPS == 60 ? 5 : 3;
			this.redrawFrame = this.tickFrame - 1;
			
			this.cachers = new Vector.<Vector.<ICacher>>(this.redrawFrame, true);
			
			for (var i:int = 0; i < this.redrawFrame; i++)
			{
				this.cachers[i] = new Vector.<ICacher>();
			}
			
			this.numberOfCachers = 0;
			this.frameCount = 0;
			
			Time.TBT = this.tickFrame / this.FPS;
			
			
			
			this.gameJuggler = foundations.juggler;
			
			root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(UpdateGameBase.restore);
			flow.addUpdateListener(UpdateGameBase.gameOver);
			flow.addUpdateListener(Time.setPause);
			flow.addUpdateListener(Time.addCacher);
			
			this.updateFlow = flow;
		}
		
		update function addCacher(cacher:ICacher):void
		{
			this.cachers[this.numberOfCachers % this.redrawFrame].push(cacher);
			
			this.numberOfCachers++;
		}
		
		update function restore():void
		{
			this.gameJuggler.purge();
			
			this.fixed = false;
			
			this.frameCount = 0;
		}
		
		update function setPause(value:Boolean):void
		{
			this.fixed = value;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.fixed)
			{
				this.gameJuggler.advanceTime(event.passedTime);
				
				if (this.frameCount == this.tickFrame)
				{
					this.frameCount = 0;
					
					this.updateFlow.dispatchUpdate(Time.tick);
					this.updateFlow.dispatchUpdate(Time.aftertick);
				}
				else if (this.frameCount == this.redrawFrame)
				{
					this.frameCount++;
					
					this.updateFlow.dispatchUpdate(Time.redraw);
				}
				else
				{
					var vector:Vector.<ICacher> = this.cachers[this.frameCount];
					var length:int = vector.length;
					
					for (var i:int = 0; i < length; i++)
					{
						vector[i].cache();
					}
					
					this.frameCount++;
				}
			}
		}
		
		update function gameOver():void
		{
			this.fixed = true;
			
			this.frameCount = 0;
		}
	}
	
}