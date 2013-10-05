package ui.game 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class GameView 
	{
		private var container:Sprite;
		
		public function GameView(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			root.addChild(this.container);
			
			this.container.visible = false;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.quitGame);
			
			flow.dispatchUpdate(Update.setGameContainer, this.container);
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