package game.world.items.technic 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.world.items.IPointCollector;
	import game.world.items.ISolderable;
	import game.world.items.ItemLogicBase;
	
	internal class TechnicLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 0;
		private const SOLDERING_POWER:int = 3;
		
		private const LEFT:int = 0;
		private const UP:int = 1;
		private const RIGHT:int = 2;
		private const DOWN:int = 3;
		
		private static var moves:Vector.<DCellXY> = new <DCellXY>[
			new DCellXY( -1, 0), new DCellXY(0, -1), new DCellXY(1, 0), new DCellXY(0, 1)];
		
		private var goal:ICoordinated;
		private var center:ICoordinated;
		
		private var points:IPointCollector;
		
		private var steps:Vector.<int> = new Vector.<int>(4, true);
		private var lastChange:DCellXY = Metric.getRandomDCell();
		
		public function TechnicLogic(foundations:GameElements) 
		{
			this.points = foundations.pointsOfInterest;
			this.points.addPointOfInterest(Game.ALWAYS_ACTIVE, this);
			
			super(new TechnicView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			this.center = this.points.findPointOfInterest(Game.CHARACTER);
			
			var tmpCell:CellXY = Metric.getTmpCell(this.center.x - 4, this.center.y + 4);
			
			while (this.actors.findObjectByCell(tmpCell.x, tmpCell.y))
				tmpCell.setValue(tmpCell.x, tmpCell.y - 1);
			
			return tmpCell;
		}
		
		
		override public function act():void
		{
			if (!this.goal || this.goal as ItemLogicBase != this.actors.findObjectByCell(this.goal.x, this.goal.y))
			{
				this.goal = this.points.findPointOfInterest(Game.TOWER);
				
				if (this.goal && Metric.distance(this.center, this.goal) > 10)
				{
					this.points.removePointOfInterest(Game.TOWER, this.goal);
					this.goal = null;
				}
			}
			
			if (!this.goal)
			{
				
			}
			else
			{
				if (Metric.distance(this, this.goal) == 1)
				{
					this.move(Metric.getTmpDCell(this.goal.x - this.x, this.goal.y - this.y), this.MOVE_SPEED);
				}
				else
				{
					if (Math.abs(this.goal.x - this.x) > Math.abs(this.goal.y - this.y))
					{
						if (this.goal.x > this.x)
						{
							this.steps[this.RIGHT] = 4;
							this.steps[this.LEFT] = 1;
						}
						else
						{
							this.steps[this.RIGHT] = 1;
							this.steps[this.LEFT] = 4;
						}
						
						if (this.goal.y > this.y)
						{
							this.steps[this.DOWN] = 3;
							this.steps[this.UP] = 2;
						}
						else
						{
							this.steps[this.DOWN] = 2;
							this.steps[this.UP] = 3;
						}
					}				
					else
					{
						if (this.goal.x > this.x)
						{
							this.steps[this.RIGHT] = 3;
							this.steps[this.LEFT] = 2;
						}
						else
						{
							this.steps[this.RIGHT] = 2;
							this.steps[this.LEFT] = 3;
						}
						
						if (this.goal.y > this.y)
						{
							this.steps[this.DOWN] = 4;
							this.steps[this.UP] = 1;
						}
						else
						{
							this.steps[this.DOWN] = 1;
							this.steps[this.UP] = 4;
						}
					}
					
					if (this.goal.x == this.x)
					{
						this.steps[this.LEFT] = this.steps[this.RIGHT] = 2;
					}
					if (this.goal.y == this.y)
					{
						this.steps[this.UP] = this.steps[this.DOWN] = 2;
					}
					
					var i:int;
					
					for (i = 0; i < 4; i++)
					{
						var change:DCellXY = TechnicLogic.moves[i];
						var actor:ItemLogicBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
						
						if (actor && !(actor is ISolderable && (actor as ISolderable).progress <= 1))
							this.steps[i] -= 8;
						
						if ((change.x == -this.lastChange.x) && (change.y == -this.lastChange.y))
							this.steps[i] -= 24;
					}
					
					var maxI:int, max:int = int.MIN_VALUE;
					
					for (i = 0; i < 4; i++)
						if (this.steps[i] > max)
						{
							max = this.steps[i];
							maxI = i;
						}
					
					this.moveInDirection(maxI);
				}
			}
		}
		
		
		private function moveInDirection(direction:int):void
		{
			this.lastChange = TechnicLogic.moves[direction];
			
			this.move(this.lastChange, this.MOVE_SPEED);
		}
		
		override protected function move(change:DCellXY, delay:int):void
		{
			var actor:ItemLogicBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
			
			if (!actor)
				super.move(change, delay);
			else if (actor is ISolderable)
			{
				var tower:ISolderable = actor as ISolderable;
				tower.applySoldering(this.SOLDERING_POWER);
				
				if (tower.progress >= 1)
				{
					this.goal = null;
					this.points.removePointOfInterest(Game.TOWER, actor);
				}
			}
		}
		
		
		internal function moveTo(target:ICoordinated):void
		{
			super.move(Metric.getTmpDCell(target.x - this.x, target.y - this.y), -1);
		}
	}
}