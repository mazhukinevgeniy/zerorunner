package ui.pauseControl 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import chaotic.game.ChaoticGame;
	import flash.ui.Keyboard;
	import ui.ChaoticUI;
	import ui.game.panel.Panel;
	
	public class PauseTypes 
	{
		private var pauseToggled:Boolean = true;
		private var isOutOfSight:Boolean = true;
		private var isInUse:Boolean = true;
		
		private var flow:IUpdateDispatcher;
		
		public function PauseTypes(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ChaoticGame.gameOver);
			
			flow.addUpdateListener(ChaoticUI.keyUp);
			flow.addUpdateListener(Panel.panel_BackToMenu);
		}
		
		public function gameOver():void
		{
			this.pauseToggled = true;
			this.isOutOfSight = true;
			this.isInUse = true;
		}
		public function panel_BackToMenu():void
		{
			this.pauseToggled = true;
			this.isInUse = true;
			this.isOutOfSight = true;
		}
		public function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P)
			{
				this.pauseToggled = !this.pauseToggled;
				this.setPause();
			}
		}
		
		private function setPause():void
		{
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticGame.flowName, ChaoticGame.setPause,
										this.pauseToggled || this.isInUse || this.isOutOfSight);
		}
	}

}