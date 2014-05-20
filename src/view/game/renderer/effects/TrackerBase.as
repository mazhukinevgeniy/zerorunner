package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.metric.ICoordinated;
	import utils.getCellId;
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
			
			this.tracked[getCellId(x, y)] = effect;
		}
		
		internal function getEffect(cellId:int):Effect
		{
			return this.tracked[cellId];
		}
	}

}