package game.world.broods.technic 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	
	internal class TechnicLogic extends ItemLogicBase
	{
		private static const LEFT:int = 0;
		private static const UP:int = 1;
		private static const RIGHT:int = 2;
		private static const DOWN:int = 3;
		
		private static const LEFT_HAND:int = -1;
		private static const RIGHT_HAND:int = 1;
		private static const NOT_IN_BYPASS:int = 0;
		
		private static var moves:Vector.<DCellXY> = new <DCellXY>[
			new DCellXY( -1, 0), new DCellXY(0, -1), new DCellXY(1, 0), new DCellXY(0, 1)];
		
		private static var directions:Vector.<int> = new <int>[TechnicLogic.LEFT, TechnicLogic.UP, TechnicLogic.RIGHT, TechnicLogic.DOWN];
		
		
		private static const config:ConfigKit = new ConfigKit(15, 0, 0);
		
		
		private var goal:ICoordinated;
		private var bypassStartingPoint:CellXY;
		
		private var hand:int;
		private var lastTouchedWall:int = -1;
		
		private var towers:IPointCollector;
		
		public function TechnicLogic(foundations:GameFoundations, world:ISearcher, towers:IPointCollector) 
		{
			this.towers = towers;
			
			this.bypassStartingPoint = new CellXY(0, 0);
			
			super(new TechnicView(foundations), foundations, world);
		}
		
		override protected function getConfig():ConfigKit
		{
			return TechnicLogic.config;
		}
		
		override protected function onSpawned():void
		{
			this.hand = TechnicLogic.NOT_IN_BYPASS;
			
			this.goal = this.towers.findPointOfInterest(Game.TOWER);
		}
		
		
		override protected function onCanMove():void
		{
			if (!this.goal)
				this.goal = this.towers.findPointOfInterest(Game.TOWER);
			
			if (this.hand == TechnicLogic.NOT_IN_BYPASS)
			{
				if (!this.tryStraightGoing(this.goal))
				{
					this.hand = (Math.random() > 0.5)?( -1):(1);
					
					if (this.goal.x > this.x)
						this.lastTouchedWall = TechnicLogic.RIGHT;
					else if (this.goal.x < this.x)
						this.lastTouchedWall = TechnicLogic.LEFT;
					else if (this.goal.y > this.y)
						this.lastTouchedWall = TechnicLogic.DOWN;
					else /*if (this.goal.y < this.y)*///todo: something is wrong, fix it
						this.lastTouchedWall = TechnicLogic.UP;
					
					this.bypassStartingPoint.setValue(this.x, this.y);
				}
			}
			
			if (this.hand != TechnicLogic.NOT_IN_BYPASS)
			{
				this.moveInDirection(this.lastTouchedWall);
				
				if (this.sureCheck())
					this.hand = TechnicLogic.NOT_IN_BYPASS;
			}
		}
		
		private function tryStraightGoing(goal:ICoordinated):Boolean
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
		private function tryVertical(goal:ICoordinated):Boolean
		{
			if (goal.y > this.y)
			{
				this.moveInDirection(TechnicLogic.DOWN);
				return true;
			}
			else if (goal.y < this.y)
			{
				this.moveInDirection(TechnicLogic.UP);
				return true;
			}
			return false;
		}
		private	function tryHorizontal(goal:ICoordinated):Boolean
		{
			if (goal.x > this.x)
			{
				this.moveInDirection(TechnicLogic.RIGHT);
				return true;
			}
			else if (goal.x < this.x)
			{
				this.moveInDirection(TechnicLogic.LEFT);
				return true;
			}
			return false;
		}
		
		
		private function moveInDirection(direction:int):void
		{
			var start:int = direction;
			
			var change:DCellXY = TechnicLogic.moves[direction];
			
			
			this.move(change);
			
			start = direction;
			
			this.lastTouchedWall = TechnicLogic.directions[(direction + this.hand + 4) % 4];
		}
		
		
		private function sureCheck():Boolean
		{	
			return distance(this.goal, this.bypassStartingPoint, "x") >= distance(this.goal, this, "x")
				   && 
				   distance(this.goal, this.bypassStartingPoint, "y") >= distance(this.goal, this, "y");
					
			function distance(p1:ICoordinated, p2:ICoordinated, coordinate:String):int
			{
				return Math.abs(p1[coordinate] - p2[coordinate]);
			}
		}
		
		
		private const SOLDERING_POWER:int = 3;
		
		override protected function onBlocked(change:DCellXY):void
		{
			var gx:int = this.x + change.x;
			var gy:int = this.y + change.y;
			
			var actor:ItemLogicBase;
			
			this.world.findObjectByCell(gx, gy).applyPush();
			
			actor = this.world.findObjectByCell(gx, gy);
			if (!actor)
			{
				this.move(change);
			}
			else
			{
				actor.offerSoldering(this, this.SOLDERING_POWER);
			}
		}
		
		override protected function onTowerHalfBuilt():void
		{
			this.goal = this.towers.findPointOfInterest(Game.TOWER);
		}
	}
}