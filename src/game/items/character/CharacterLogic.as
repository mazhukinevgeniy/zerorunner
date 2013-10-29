package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.ItemBase;
	import game.items.Items;
	import game.items.items_internal;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	use namespace items_internal;
	
	internal class CharacterLogic extends ItemBase
	{
		private const SOLDERING_POWER:int = 2;//TODO: replace
		
		private var input:InputManager;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		private var scene:IScene;
		
		public function CharacterLogic(elements:GameElements) 
		{
			this.input = elements.input;
			this.flow = elements.flow;
			this.items = elements.items;
			this.scene = elements.scene;
			
			var cell:CellXY = new CellXY
					(Game.BORDER_WIDTH, 
					 Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(elements, cell);
			
			this.points = elements.pointsOfInterest;
			
			//TODO: initialize all cores
			
			this.flow.dispatchUpdate(Update.setCenter, this);
		}
		
		
		
		
		
		
	}

}