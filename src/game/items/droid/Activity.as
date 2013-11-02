package game.items.droid 
{
	import game.items.base.ActivityCore;
	
	internal class Activity extends ActivityCore
	{
		
		public function Activity() 
		{
			
		}
		
		override public function act():void
		{
			if (!this.goal || (this.goal as ExistenceCore).item != this.items.findObjectByCell(this.goal.x, this.goal.y))
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
						var item:ItemBase = this.items.findObjectByCell(position.x + change.x, position.y + change.y);
						
						if (item && !(item.contraption && !item.contraption.finished))
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
	}

}