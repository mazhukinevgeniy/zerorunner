package ui.game 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.core.UpdateManager;
	import game.ZeroRunner;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.ChaoticUI;
	
	public class GameView 
	{
		private var container:Sprite;
		
		public function GameView(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			root.addChild(this.container);
			
			this.container.visible = false;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ChaoticUI.newGame);
			flow.addUpdateListener(ZeroRunner.quitGame);
			
			flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, 
									ZeroRunner.setGameContainer, this.container);
		}
		
		update function newGame():void
		{
			this.container.visible = true;
		}
		
		update function quitGame():void
		{
			this.container.visible = false;
		}
	}

}