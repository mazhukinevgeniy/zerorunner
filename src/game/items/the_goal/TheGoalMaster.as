package game.items.the_goal 
{
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import utils.updates.update;
	
	public class TheGoalMaster extends CheckpointMasterBase
	{
		private var currentGoal:TheGoal;
		
		private var center:ICoordinated;
		
		public function TheGoalMaster(elements:GameElements) 
		{
			super(elements);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		override protected function gameStarted():void 
		{
			var x:int, y:int;
			
			do
			{
				x = Game.MAP_WIDTH * Math.random();
				y = Game.MAP_WIDTH * Math.random();
			}
			while (this.elements.items.findAnyObjectByCell(x, y) || this.elements.scene.getSceneCell(x, y) != Game.SCENE_GROUND);
			
			var cell:CellXY = new CellXY(x, y);
			
			this.currentGoal = new TheGoal(this, this.elements, cell);
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{
			if (Game.distance(this.center, this.currentGoal) < 2)
				return this.currentGoal;
			else
				return CheckpointMasterBase.ILLEGAL_CELL;
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			this.elements.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_WON);
			
			this.currentGoal = null;
		}
	}

}