package model.items 
{
	import binding.IBinder;
	import controller.observers.game.IQuitGameHandler;
	
	use namespace items_internal;
	
	public class MasterBase implements IQuitGameHandler
	{
		protected var binder:IBinder;
		
		public function MasterBase(binder:IBinder) 
		{
			this.binder = binder;
			
			binder.notifier.addGameStatusObserver(this);//TODO: make sure it can't be doubleadded
		}
		
		public function quitGame():void { this.onGameFinished(); }
		
		
		internal function actOn(puppet:PuppetBase):void
		{
			if (puppet.occupation != Game.OCCUPATION_DYING)
				this.act(puppet);
		}
		
		
		protected function act(puppet:PuppetBase):void { }
		protected function onGameFinished():void { }
		
		
		public function spawnPuppet(x:int, y:int):void
		{
			throw new Error("must implement");
		}
	}

}