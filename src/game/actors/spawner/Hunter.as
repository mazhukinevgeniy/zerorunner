package game.actors.spawner 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	internal class Hunter 
	{
		private static const configuration = new XML
		(
			<actor>
				<type>1</type>
				<baseHP>3</baseHP>
				<speed>2</speed>
				<configuration>
					<check>NormalLandscapeCheck</check>
					<check>OutOfBoundsCheck</check>
					<check>IsGrindedCheck</check>
					<action>HeuristicGoalPursuing</action>
				</configuration>
				<getCell>getRandomCell</getCell>
				<chance>0.3</chance>
			</actor>
		);
		
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
		
		private var previousCell:CellXY; // TODO: is needed?
		private var goal:CellXY;
		private var bypassStartingPoint:CellXY;
		
		private var hand:int;
		
		private var lastTouchedWall:int = -1;
		
		public function Hunter() 
		{
			super(Hunter.configuration);
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
	}

}