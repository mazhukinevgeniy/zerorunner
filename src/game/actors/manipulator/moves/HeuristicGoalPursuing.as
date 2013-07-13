package game.actors.manipulator.moves 
{
	import game.actors.manipulator.actions.Bite;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	public class HeuristicGoalPursuing extends MoveBase
	{
		
		
		private var scene:IScene;
		
		private var actor:Puppet;
		
		private var bite:Bite;
		
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			
		}
		
		private function tryStraightGoing(goal:CellXY):Boolean
		{
			if (Math.abs(goal.x - this.actor.x) > Math.abs(goal.y - this.actor.y))
			{
				if (!this.tryHorizontal(goal))
					if (!this.tryVertical(goal))
						return false;
				return true;
			}				
			else
			{
				if (!this.tryVertical(goal))
					if (!this.tryHorizontal(goal))
						return false;
				return true;	
			}
		}
		private function tryVertical(goal:CellXY):Boolean
		{
			if ((goal.y > this.actor.y) && !this.surroundings[this.DOWN])
			{
				this.move(this.DOWN);
				return true;
			}
			else if ((goal.y < this.actor.y) && !this.surroundings[this.UP])
			{
				this.move(this.UP);
				return true;
			}
			return false;
		}
		private	function tryHorizontal(goal:CellXY):Boolean
		{
			if ((goal.x > this.actor.x) && !this.surroundings[this.RIGHT])
			{
				this.move(this.RIGHT);
				return true;
			}
			else if ((goal.x < this.actor.x) && !this.surroundings[this.LEFT])
			{
				this.move(this.LEFT);
				return true;
			}
			return false;
		}
		
		private function refreshCells():void
		{
			this.surroundings[this.LEFT] = SceneFeature.FALL == this.scene.getSceneCell(new CellXY(this.actor.x - 1, this.actor.y));
			this.surroundings[this.RIGHT] = SceneFeature.FALL == this.scene.getSceneCell(new CellXY(this.actor.x + 1, this.actor.y));
			this.surroundings[this.UP] = SceneFeature.FALL == this.scene.getSceneCell(new CellXY(this.actor.x, this.actor.y - 1));
			this.surroundings[this.DOWN] = SceneFeature.FALL == this.scene.getSceneCell(new CellXY(this.actor.x, this.actor.y + 1));
		}
		
		private function move(direction:int):void
		{
			var start:int = direction;
			var data:Object = this.actor.data.heuristic;
			
			do
			{
				if (!this.surroundings[direction])
				{
					this.callMove(this.actor, this.moves[direction]);
					
					start = direction;
				}
				else
					direction = (direction - data.hand + 4) % 4;
			}
			while (start != direction);
			
			data.lastTouchedWall = this.directions[(direction + data.hand + 4) % 4];
		}
		
		
		private function sureCheck(data:Object):Boolean
		{	
			return distance(data.goal, data.bypassStartingPoint, "x") >= distance(data.goal, this.actor.getCell(), "x")
				   && 
				   distance(data.goal, data.bypassStartingPoint, "y") >= distance(data.goal, this.actor.getCell(), "y");
					
			function distance(p1:CellXY, p2:CellXY, coordinate:String):int
			{
				return Math.abs(p1[coordinate] - p2[coordinate]);
			}
		}
		
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.bite.act(item, change);
		}
	}

}