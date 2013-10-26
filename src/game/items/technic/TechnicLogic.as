package game.items.technic 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.cores.ExistenceCore;
	import game.items.base.ItemBase;
	import game.items.Items;
	import game.items.items_internal;
	import game.points.IPointCollector;
	
	use namespace items_internal;
	
	internal class TechnicLogic extends ItemBase
	{
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
		private var items:Items;
		
		private var steps:Vector.<int> = new Vector.<int>(4, true);
		private var lastChange:DCellXY = Metric.getRandomDCell();
		
		public function TechnicLogic(cell:ICoordinated, elements:GameElements) 
		{
			const MOVE_SPEED:int = 0;
			
			this.items = elements.items;
			this.points = elements.pointsOfInterest;
			this.points.addPointOfInterest(Game.ALWAYS_ACTIVE, this.existence);
			
			this.center = this.points.findPointOfInterest(Game.CHARACTER);
			
			super(elements, new ExistenceCore(this, elements, cell, MOVE_SPEED));
			
		}
		
		
		override public function act():void
		{
			if (!this.goal || this.goal as ExistenceCore != this.items.findObjectByCell(this.goal.x, this.goal.y))
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
				var position:ICoordinated = this.existence;
				
				if (Metric.distance(position, this.goal) == 1)
				{
					this.existence.moveTo(this.goal);
				}
				else
				{
					if (Math.abs(this.goal.x - position.x) > Math.abs(this.goal.y - position.y))
					{
						if (this.goal.x > position.x)
						{
							this.steps[this.RIGHT] = 4;
							this.steps[this.LEFT] = 1;
						}
						else
						{
							this.steps[this.RIGHT] = 1;
							this.steps[this.LEFT] = 4;
						}
						
						if (this.goal.y > position.y)
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
						if (this.goal.x > position.x)
						{
							this.steps[this.RIGHT] = 3;
							this.steps[this.LEFT] = 2;
						}
						else
						{
							this.steps[this.RIGHT] = 2;
							this.steps[this.LEFT] = 3;
						}
						
						if (this.goal.y > position.y)
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
					
					if (this.goal.x == position.x)
					{
						this.steps[this.LEFT] = this.steps[this.RIGHT] = 2;
					}
					if (this.goal.y == position.y)
					{
						this.steps[this.UP] = this.steps[this.DOWN] = 2;
					}
					
					var i:int;
					
					for (i = 0; i < 4; i++)
					{
						var change:DCellXY = TechnicLogic.moves[i];
						var item:ExistenceCore = this.items.findObjectByCell(position.x + change.x, position.y + change.y);
						
						if (item && !(item.item.contraption && !item.item.contraption.finished)) //TODO: fix syntax
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
			var change:DCellXY = this.lastChange = TechnicLogic.moves[direction];
			
			this.existence.move(this.lastChange);
		}
		
	}
}