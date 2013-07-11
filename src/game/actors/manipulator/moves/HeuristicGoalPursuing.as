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
		private const LEFT:int = 0;
		private const UP:int = 1;
		private const RIGHT:int = 2;
		private const DOWN:int = 3;
		
		private const LEFT_HAND:int = -1;
		private const RIGHT_HAND:int = 1;
		private const NOT_IN_BYPASS:int = 0;
		
		private var moves:Vector.<DCellXY>;
		private var directions:Vector.<int>;
		private var surroundings:Vector.<Boolean>;
		
		private var scene:IScene;
		
		private var actor:Puppet;
		
		private var bite:Bite;
		
		
		public function HeuristicGoalPursuing(newScene:IScene, bite:Bite) 
		{
			this.scene = newScene;
			
			this.bite = bite;
			
			this.initializeHelperArrays();
		}
		
		private function initializeHelperArrays():void
		{
			this.moves = new Vector.<DCellXY>(4, true);
			this.moves[this.RIGHT] = new DCellXY(1, 0);
			this.moves[this.LEFT] = new DCellXY(-1, 0);
			this.moves[this.DOWN] = new DCellXY(0, 1);
			this.moves[this.UP] = new DCellXY(0, -1);
			
			this.directions = new <int>[this.LEFT,
										this.UP,
										this.RIGHT,
										this.DOWN];
			
			this.surroundings = new Vector.<Boolean>(4, true);
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			var data:Object = (item.data.heuristic = new Object());
			
			data.previousCell = (data.goal = this.searcher.getCharacterCell());
			data.hand = this.NOT_IN_BYPASS;
			data.lastTouchedWall = new int( -1);
			data.bypassStartingPoint = new CellXY( -1, -1);
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			var data:Object = item.data.heuristic;
			this.actor = item;
			
			if (!data.previousCell.isEqualTo(this.actor.getCell()))
				data.hand = this.NOT_IN_BYPASS;
			
			if (data.hand == this.NOT_IN_BYPASS) 
				data.goal = this.searcher.getCharacterCell();
			
			this.refreshCells();
			
			if (data.hand == this.NOT_IN_BYPASS)
			{
				if (!this.tryStraightGoing(data.goal))
				{
					data.hand = (Math.random() > 0.5)?(-1):(1);
					
					if (data.goal.x > this.actor.x)
						data.lastTouchedWall = this.RIGHT;
					else if (data.goal.x < this.actor.x)
						data.lastTouchedWall = this.LEFT;
					else if (data.goal.y > this.actor.y)
						data.lastTouchedWall = this.DOWN;
					else if (data.goal.y < this.actor.y)
						data.lastTouchedWall = this.UP;
					
					data.bypassStartingPoint = this.actor.getCell();
				}
			}
			
			if (data.hand != this.NOT_IN_BYPASS)
			{
				this.move(data.lastTouchedWall);
				
				if (this.sureCheck(data) || this.actor.getCell().isEqualTo(data.bypassStartingPoint))
					data.hand = this.NOT_IN_BYPASS;
			}
			
			data.previousCell = this.actor.getCell();
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