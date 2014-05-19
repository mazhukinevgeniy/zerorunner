package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.metric.ICoordinated;
	import utils.normalize;
	import view.game.renderer.structs.Effect;
	
	internal class TrackerBase implements INewGameHandler, IGameFrameHandler
	{
		private var tracked:Array;
		
		public function TrackerBase(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.tracked = new Array();
		}
		
		public function gameFrame(frame:int):void
		{
			for (var key:String in this.tracked)
			{
				this.tracked[key].duration--;
				
				if (this.tracked[key].duration == 0)
					delete this.tracked[key];
			}
		}
		
		protected function addEffect(effect:Effect, cell:ICoordinated):void
		{
			var x:int = cell.x;
			var y:int = cell.y;
			
			this.tracked[x + y * Game.MAP_WIDTH] = effect;
		}
		
		internal function getEffect(x:int, y:int):Effect
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.tracked[x + y * Game.MAP_WIDTH];
		}
	}

}