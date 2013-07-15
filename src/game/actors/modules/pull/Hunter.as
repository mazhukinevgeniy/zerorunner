package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	
	internal class Hunter extends ActorBase
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
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.getCell(), 1);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		
		override protected function onCanMove():void
		{
			if (!this.previousCell.isEqualTo(this.getCell()))
				this.hand = Hunter.NOT_IN_BYPASS;
			
			if (this.hand == Hunter.NOT_IN_BYPASS) 
				this.searcher.getCharacterCell(this.goal);
			
			this.refreshCells();
			
			if (this.hand == Hunter.NOT_IN_BYPASS)
			{
				if (!this.tryStraightGoing(this.goal))
				{
					this.hand = (Math.random() > 0.5)?( -1):(1);
					
					if (this.goal.x > this.x)
						this.lastTouchedWall = Hunter.RIGHT;
					else if (this.goal.x < this.x)
						this.lastTouchedWall = Hunter.LEFT;
					else if (this.goal.y > this.y)
						this.lastTouchedWall = Hunter.DOWN;
					else if (this.goal.y < this.y)
						this.lastTouchedWall = Hunter.UP;
					
					this.bypassStartingPoint = this.getCell();
				}
			}
			
			if (this.hand != Hunter.NOT_IN_BYPASS)
			{
				this.move(this.lastTouchedWall);
				
				if (this.sureCheck() || this.getCell().isEqualTo(this.bypassStartingPoint))
					this.hand = Hunter.NOT_IN_BYPASS;
			}
			
			this.previousCell = this.getCell();
		}
		
		private function tryStraightGoing(goal:CellXY):Boolean
		{
			if (Math.abs(goal.x - this.x) > Math.abs(goal.y - this.y))
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
			if ((goal.y > this.y) && !Hunter.surroundings[Hunter.DOWN])
			{
				this.move(Hunter.DOWN);
				return true;
			}
			else if ((goal.y < this.y) && !Hunter.surroundings[Hunter.UP])
			{
				this.move(Hunter.UP);
				return true;
			}
			return false;
		}
		private	function tryHorizontal(goal:CellXY):Boolean
		{
			if ((goal.x > this.x) && !Hunter.surroundings[Hunter.RIGHT])
			{
				this.move(Hunter.RIGHT);
				return true;
			}
			else if ((goal.x < this.x) && !Hunter.surroundings[Hunter.LEFT])
			{
				this.move(Hunter.LEFT);
				return true;
			}
			return false;
		}
		
		private function refreshCells():void
		{
			Hunter.surroundings[Hunter.LEFT] = SceneFeature.FALL == this.scene.getSceneCell(this.x - 1, this.y);
			Hunter.surroundings[Hunter.RIGHT] = SceneFeature.FALL == this.scene.getSceneCell(this.x + 1, this.y);
			Hunter.surroundings[Hunter.UP] = SceneFeature.FALL == this.scene.getSceneCell(this.x, this.y - 1);
			Hunter.surroundings[Hunter.DOWN] = SceneFeature.FALL == this.scene.getSceneCell(this.x, this.y + 1);
		}
		
		private function move(direction:int):void
		{
			var start:int = direction;
			
			do
			{
				if (!Hunter.surroundings[direction])
				{
					this.tryMove(Hunter.moves[direction]);
					
					start = direction;
				}
				else
					direction = (direction - this.hand + 4) % 4;
			}
			while (start != direction);
			
			this.lastTouchedWall = Hunter.directions[(direction + this.hand + 4) % 4];
		}
		
		
		private function sureCheck():Boolean
		{	
			return distance(this.goal, this.bypassStartingPoint, "x") >= distance(this.goal, this.getCell(), "x")
				   && 
				   distance(this.goal, this.bypassStartingPoint, "y") >= distance(this.goal, this.getCell(), "y");
					
			function distance(p1:CellXY, p2:CellXY, coordinate:String):int
			{
				return Math.abs(p1[coordinate] - p2[coordinate]);
			}
		}
		
		
		override protected function onBlocked(change:DCellXY):void
		{
			//this.bite.act(item, change);
			//TODO: do something
		}
	}

}