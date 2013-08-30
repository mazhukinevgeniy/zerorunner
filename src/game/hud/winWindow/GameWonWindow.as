package game.hud.winWindow 
{
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.hud.GameOverWindow;
	import game.IGame;
	import game.utils.RandomGameState;
	import starling.display.DisplayObjectContainer;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class GameWonWindow extends GameOverWindow
	{
		private var flow:IUpdateDispatcher;
		private var game:IGame;
		
		public function GameWonWindow(foundations:GameFoundations) 
		{
			this.flow = foundations.flow;
			this.game = foundations.game;
			
			super(this.flow);
		}
		
		override protected function addMessage(message:DisplayObjectContainer):void
		{
			var tmp:Label = new Label();
			tmp.text = "You win";
			
			tmp.x = 20;
			tmp.y = 20;
			
			message.addChild(tmp);
		}
		
		override protected function addUpdateListeners(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.gameWon);
		}
		
		update function gameWon():void
		{
			this.flow.dispatchUpdate(Update.reparametrize, new RandomGameState(this.game));
			
			this.update::gameOver();
		}
	}

}