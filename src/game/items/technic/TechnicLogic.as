package game.items.technic 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.core.metric.ProtectedDCellXY;
	import game.GameElements;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.points.IPointCollector;
	
	internal class TechnicLogic extends PuppetBase //TODO: rename logics to puppets as there's no logic in them
	{
		private const SOLDERING_POWER:int = 3;
		
		private const LEFT:int = 0;
		private const UP:int = 1;
		private const RIGHT:int = 2;
		private const DOWN:int = 3;
		
		private static var moves:Vector.<DCellXY> = new <DCellXY>[
			new ProtectedDCellXY( -1, 0), new ProtectedDCellXY(0, -1), 
			new ProtectedDCellXY(1, 0), new ProtectedDCellXY(0, 1)];
		
		private var goal:ICoordinated;
		private var center:ICoordinated;
		
		private var points:IPointCollector;
		
		private var steps:Vector.<int> = new Vector.<int>(4, true);
		private var lastChange:DCellXY = Metric.getRandomDCell();
		
		public function TechnicLogic(cell:CellXY, elements:GameElements) 
		{
			const MOVE_SPEED:int = 0;
			
			this.items = elements.items;
			this.points = elements.pointsOfInterest;
			this.points.addAlwaysActive(this);
			
			this.center = this.points.getCharacter();
			
			super(elements, cell);
			//TODO: override occupations
		}
		
		
		
		private function moveInDirection(direction:int):void
		{
			var change:DCellXY = this.lastChange = TechnicLogic.moves[direction];
			
			//this.existence.move(this.lastChange);
			//TODO: implement moving
		}
		
	}
}