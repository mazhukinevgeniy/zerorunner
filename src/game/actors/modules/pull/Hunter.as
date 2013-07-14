package game.actors.modules.pull 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	internal class Hunter 
	{
		private static const HP:int = 3;
		private static const MOVE_SPEED:int = 2;
		private static const ACTION_SPEED:int = 1000;
		
		private static const LEFT:int = 0;
		private static const UP:int = 1;
		private static const RIGHT:int = 2;
		private static const DOWN:int = 3;
		
		private static const LEFT_HAND:int = -1;
		private static const RIGHT_HAND:int = 1;
		private static const NOT_IN_BYPASS:int = 0;
		
		private static var moves:Vector.<DCellXY> = new Vector.<DCellXY>(4, true);
			Hunter.moves[Hunter.RIGHT] = new DCellXY(1, 0);
			Hunter.moves[Hunter.LEFT] = new DCellXY(-1, 0);
			Hunter.moves[Hunter.DOWN] = new DCellXY(0, 1);
			Hunter.moves[Hunter.UP] = new DCellXY(0, -1);
		
		private static var directions:Vector.<int> = new <int>[Hunter.LEFT, Hunter.UP, Hunter.RIGHT, Hunter.DOWN];
		private static var surroundings:Vector.<Boolean> = new Vector.<Boolean>(4, true);
		
		private var previousCell:CellXY;
		private var goal:CellXY;
		private var bypassStartingPoint:CellXY;
		
		private var hand:int;
		
		private var lastTouchedWall:int = -1;
		
		
		public function Hunter() 
		{
			super(Hunter.HP, Hunter.MOVE_SPEED, Hunter.ACTION_SPEED);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		
		override protected function onCanMove():void
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