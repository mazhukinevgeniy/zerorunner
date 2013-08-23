package game.world.broods.technic 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	
	public class TechnicLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 0;
		
		private const LEFT:int = 0;
		private const UP:int = 1;
		private const RIGHT:int = 2;
		private const DOWN:int = 3;
		
		private static var moves:Vector.<DCellXY> = new <DCellXY>[
			new DCellXY( -1, 0), new DCellXY(0, -1), new DCellXY(1, 0), new DCellXY(0, 1)];
		
		private var goal:ICoordinated;
		
		private var towers:IPointCollector;
		
		public function TechnicLogic(foundations:GameFoundations, towers:IPointCollector) 
		{
			this.towers = towers;
			
			super(new TechnicView(foundations), foundations);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.goal = this.towers.findPointOfInterest(Game.TOWER);
		}
		
		
		 protected function onCanMove():void
		{
			if (!this.goal)
				this.goal = this.towers.findPointOfInterest(Game.TOWER);
			
			if (!this.goal)
			{
				
			}
			else
			{
				if (Math.abs(this.goal.x - this.x) > Math.abs(this.goal.y - this.y))
				{
					if (!this.tryHorizontal())
						!this.tryVertical();
				}				
				else
				{
					if (!this.tryVertical())
						this.tryHorizontal();
				}
			}
		}
		
		private function tryVertical():Boolean
		{
			if (this.goal.y > this.y)
			{
				this.moveInDirection(this.DOWN);
				return true;
			}
			else if (this.goal.y < this.y)
			{
				this.moveInDirection(this.UP);
				return true;
			}
			return false;
		}
		private	function tryHorizontal():Boolean
		{
			if (this.goal.x > this.x)
			{
				this.moveInDirection(this.RIGHT);
				return true;
			}
			else if (this.goal.x < this.x)
			{
				this.moveInDirection(this.LEFT);
				return true;
			}
			return false;
		}
		
		
		private function moveInDirection(direction:int):void
		{
			var change:DCellXY = TechnicLogic.moves[direction];
			
			this.move(change, this.MOVE_SPEED);
		}
		
		
		private const SOLDERING_POWER:int = 3;
		
		protected function onTowerHalfBuilt():void
		{
			this.goal = this.towers.findPointOfInterest(Game.TOWER);
		}
	}
}