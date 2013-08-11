package ui.game 
{
	import game.ZeroRunner;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.ChaoticUI;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
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