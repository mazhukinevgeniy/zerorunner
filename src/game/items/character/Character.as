package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	
	internal class Character extends PuppetBase
	{
		private var flow:IUpdateDispatcher;
		
		
		internal var isFlying:Boolean = false;
		
		public function Character(master:MasterBase, elements:GameElements) 
		{
			this.flow = elements.flow;
			
			var cell:CellXY = new CellXY
					(10, 
					 Game.MAP_WIDTH - 11);//TODO: get rid of this dirty hardcode
			
			super(master, elements, cell);
		}
		
		override protected function get movespeed():int { return 2; }
		override public function get type():int { return Game.ITEM_CHARACTER; }
		
		override protected function onMoved(change:DCellXY):void 
		{
			this.flow.dispatchUpdate(Update.moveCenter, change, this.movespeed);
		}
		
		override protected function onSpawned():void 
		{
			this.flow.dispatchUpdate(Update.setCenter, this);
		}
		
		override protected function onDied():void 
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_LOST);
		}
	}

}