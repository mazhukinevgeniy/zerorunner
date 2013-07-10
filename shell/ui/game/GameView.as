package ui.game 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import chaotic.game.ChaoticGame;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.ChaoticUI;
	import ui.game.panel.Panel;
	
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
			flow.addUpdateListener(Panel.panel_BackToMenu);
			
			var gameContainer:Sprite = new Sprite();
			this.container.addChild(gameContainer);
			flow.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticGame.flowName, 
									ChaoticGame.setGameContainer, gameContainer);
				
			this.container.addChild(new Panel(flow));
		}
		
		public function newGame():void
		{
			this.container.visible = true;
		}
		
		public function panel_BackToMenu():void
		{
			this.container.visible = false;
		}
	}

}