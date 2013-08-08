package game.time 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	public class Time
	{
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
		
		public function Time(root:Sprite, flow:IUpdateDispatcher) 
		{
			new PauseTypes(flow);
			
			this.FPS = Starling.current.nativeStage.frameRate;
			this.tickFrame = this.FPS == 60 ? 7 : 3;
			this.redrawFrame = this.tickFrame - 1;
			
			this.cachers = new Vector.<Vector.<ICacher>>(this.redrawFrame, true);
			
			for (var i:int = 0; i < this.redrawFrame; i++)
			{
				this.cachers[i] = new Vector.<ICacher>();
			}
			
			this.numberOfCachers = 0;
			this.frameCount = 0;
			
			Time.TBT = this.tickFrame / this.FPS; // multiply by 0.95 if tweens would be not fast enough
			//TODO: remove the covardly note above
			
			
			
			this.gameJuggler = new Juggler();
			
			root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.setPause);
			flow.addUpdateListener(ZeroRunner.gameOver);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
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
					
					this.updateFlow.dispatchUpdate(ZeroRunner.tick);
					this.updateFlow.dispatchUpdate(ZeroRunner.aftertick);
				}
				else if (this.frameCount == this.redrawFrame)
				{
					this.frameCount++;
					
					this.updateFlow.dispatchUpdate(ZeroRunner.redraw);
					//TODO: force redraw, ie removeChildren() and addChildAtLine(..)
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
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(Juggler, this.gameJuggler);
		}
	}
	
}