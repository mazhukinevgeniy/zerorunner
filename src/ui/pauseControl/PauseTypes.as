package ui.pauseControl 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import flash.ui.Keyboard;
	import game.ZeroRunner;
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
			
			flow.addUpdateListener(ZeroRunner.gameOver);
			flow.addUpdateListener(ChaoticUI.newGame);
			flow.addUpdateListener(ChaoticUI.keyUp);
			flow.addUpdateListener(Panel.panel_BackToMenu);
			flow.addUpdateListener(Panel.panel_RollOver);
			flow.addUpdateListener(Panel.panel_RollOut);
			
			this.flow = flow;
		}
		
		public function newGame():void
		{
			this.pauseToggled = false;
			this.isInUse = false;
			this.isOutOfSight = false;
			
			this.setPause();
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
			
			this.setPause();
		}
		public function panel_RollOver():void
		{
			this.isInUse = true;
			
			this.setPause();
		}
		public function panel_RollOut():void
		{
			this.isInUse = false;
			
			this.setPause();
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
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ZeroRunner.setPause,
										this.pauseToggled || this.isInUse || this.isOutOfSight);
		}
	}

}