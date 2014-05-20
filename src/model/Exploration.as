package model 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import flash.utils.ByteArray;
	import model.interfaces.IExploration;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import utils.getCellId;
	
	internal class Exploration implements IExploration, INewGameHandler, IGameFrameHandler, IQuitGameHandler
	{
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		
		
		private var visited:ByteArray;
		
		private var status:IStatus;
		private var scene:IScene;
		
		public function Exploration(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.visited = new ByteArray();
			
			this.status = binder.gameStatus;
			this.scene = binder.scene;
		}
		
		public function newGame():void
		{
			var length:int = this.visited.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			var i:int;
			for (i = 0; i < length; i++)
				this.visited[i] = this.NOT_VISITED;
			
			this.gameFrame(Game.FRAME_TO_UNLOCK_ACHIEVEMENTS);
		}
		
		public function gameFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var center:ICoordinated = this.status.getLocationOfHero();
				
				var iGoal:int = center.x + 8;
				var jGoal:int = center.y + 6;
				
				for (var i:int = center.x - 7; i < iGoal; i++)
					for (var j:int = center.y - 5; j < jGoal; j++)
					{
						var cell:int = getCellId(i, j);
						
						if (this.visited[cell] == this.NOT_VISITED)
						{
							this.visited[cell] = this.VISITED;
						}
					}
			}
		}
		
		public function quitGame():void
		{
			this.visited.clear();
		}
		
		
		
		
		public function getExplored(cellId:int):int
		{
			var toReturn:int;
			
			if (this.visited[cellId] == this.VISITED)
				toReturn = this.scene.getSceneCell(cellId);
			else
				toReturn = Game.SCENE_NONE;
			
			return toReturn;
		}
	}

}