package model.items.character 
{
	import game.fuel.IFuel;
	import game.GameElements;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	
	internal class Character extends PuppetBase
	{
		private var flow:IUpdateDispatcher;
		private var fuel:IFuel;
		
		
		public function Character(master:CharacterMaster, elements:GameElements, cell:ICoordinated) 
		{
			this.flow = elements.flow;
			this.fuel = elements.fuel;
			
			super(master, elements, cell);
		}
		
		override protected function get movespeed():int { return 2; }
		override protected function get flyingSpeed():int { return 1; }
		override public function get type():int { return Game.ITEM_CHARACTER; }
		
		override protected function get canFly():Boolean 
		{ 
			return this.fuel.getAmountOfFuel() > 0;
		}
		
		override protected function get isDestructible():Boolean 
		{
			return false;
		}
		
		override protected function onUnstabilized():void 
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_LOST);
		}
	}

}