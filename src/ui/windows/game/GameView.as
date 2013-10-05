package ui.windows.game 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class GameView extends Sprite
	{
		
		public function GameView(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			root.addChild(this);
			this.visible = false;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.quitGame);
			
			flow.dispatchUpdate(Update.setGameContainer, this);
		}
		
		update function newGame():void
		{
			this.visible = true;
		}
		
		update function quitGame():void
		{
			this.visible = false;
		}
	}

}