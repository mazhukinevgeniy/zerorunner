package view.game.renderer.effects 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.metric.ICoordinated;
	import utils.getCellId;
	import utils.StructPool;
	
	internal class TrackerBase
	{
		private var pool:StructPool;
		private var tracked:Array;
		
		public function TrackerBase(binder:IBinder) 
		{
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_FRAME,
			                                        this.gameFrame);
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			
			this.pool = new StructPool(Effect);
		}
		
		private function newGame():void
		{
			this.tracked = new Array();
		}
		
		private function gameFrame():void
		{
			for (var key:String in this.tracked)
			{
				var eff:Effect = this.tracked[key];
				
				eff.duration--;
				
				if (eff.duration == 0)
				{
					delete this.tracked[key];
					
					this.pool.freeStruct(eff);
				}
			}
		}
		
		protected function addEffect(duration:int, cell:ICoordinated):void
		{
			var effect:Effect = this.pool.getStruct();
			effect.duration = duration;
			
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