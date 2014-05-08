package model.items.character 
{
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	
	internal class Character extends PuppetBase
	{
		private var flow:IUpdateDispatcher;
		private var fuel:IFuel;
		
		
		public function Character(master:CharacterMaster, cell:ICoordinated) 
		{
			//this.fuel = fuel;
			//TODO: pass something
			
			super(master, cell);
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