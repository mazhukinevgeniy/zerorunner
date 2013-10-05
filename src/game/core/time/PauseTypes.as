package game.core.time 
{
	import flash.ui.Keyboard;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class PauseTypes 
	{
		private var pauseToggled:Boolean = true;
		private var isOutOfSight:Boolean = true;
		
		private var flow:IUpdateDispatcher;
		
		public function PauseTypes(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.gameStopped);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.keyUp);
			
			this.flow = flow;
		}
		
		update function newGame():void
		{
			this.pauseToggled = false;
			this.isOutOfSight = false;
			
			this.setPause();
		}
		update function gameStopped():void
		{
			this.pauseToggled = true;
			this.isOutOfSight = true;
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P)
			{
				this.pauseToggled = !this.pauseToggled;
				this.setPause();
			}
		}
		
		private function setPause():void
		{
			this.flow.dispatchUpdate(Update.setPause, this.pauseToggled || this.isOutOfSight);
		}
	}

}