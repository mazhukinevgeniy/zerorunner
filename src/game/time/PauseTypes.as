package game.time 
{
	import game.ui.panel.Panel;
	import ui.ChaoticUI;
	import flash.ui.Keyboard;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class PauseTypes 
	{
		private var pauseToggled:Boolean = true;
		private var isOutOfSight:Boolean = true;
		private var isInUse:Boolean = true;
		
		private var flow:IUpdateDispatcher;
		
		public function PauseTypes(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(UpdateGameBase.gameOver);
			flow.addUpdateListener(ChaoticUI.newGame);
			flow.addUpdateListener(ChaoticUI.keyUp);
			flow.addUpdateListener(Panel.panel_RollOver);
			flow.addUpdateListener(Panel.panel_RollOut);
			
			this.flow = flow;
		}
		
		update function newGame():void
		{
			this.pauseToggled = false;
			this.isInUse = false;
			this.isOutOfSight = false;
			
			this.setPause();
		}
		update function gameOver():void
		{
			this.pauseToggled = true;
			this.isOutOfSight = true;
			this.isInUse = true;
		}
		
		update function panel_RollOver():void
		{
			this.isInUse = true;
			
			this.setPause();
		}
		update function panel_RollOut():void
		{
			this.isInUse = false;
			
			this.setPause();
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
			this.flow.dispatchUpdate(Time.setPause, this.pauseToggled || this.isInUse || this.isOutOfSight);
		}
	}

}