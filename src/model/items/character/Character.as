package model.items.character 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	
	internal class Character extends PuppetBase
	{
		private var gameController:IGameController;
		
		public function Character(master:CharacterMaster, cell:ICoordinated, binder:IBinder) 
		{
			this.gameController = binder.gameController;
			
			super(master, cell);
		}
		
		override protected function get movespeed():int { return 2; }
		override public function get type():int { return Game.ITEM_CHARACTER; }
		
		override protected function get isDestructible():Boolean 
		{
			return false;
		}
		
		override protected function onUnstabilized():void 
		{
			this.gameController.gameStopped(Game.ENDING_LOST);
		}
	}

}