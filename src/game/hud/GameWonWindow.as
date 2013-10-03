package game.hud 
{
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.data.IGame;
	import game.hud.GameOverWindow;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class GameWonWindow extends GameOverWindow
	{
		private var flow:IUpdateDispatcher;
		private var game:IGame;
		
		private var roundWon:Label;
		private var runWon:Label;
		
		private var labelContainer:Sprite;
		
		public function GameWonWindow(foundations:GameFoundations) 
		{
			this.flow = foundations.flow;
			this.game = foundations.game;
			
			super(foundations.flow);
			
			//TODO: remove it
			
			this.roundWon = new Label();
			this.roundWon.text = "You win!";
			
			this.runWon = new Label();
			this.runWon.text = "You win! Run is finished!";
		}
		
		override protected function addMessage(message:DisplayObjectContainer):void
		{
			this.labelContainer = new Sprite();
			
			this.labelContainer.x = 20;
			this.labelContainer.y = 20;
			
			message.addChild(this.labelContainer);
		}
		
		override protected function addUpdateListeners(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.gameWon);
		}
		
		update function gameWon():void
		{
			this.labelContainer.removeChildren();
			
			if ((this.game).level > Game.LEVELS_PER_RUN)
			{
				this.labelContainer.addChild(this.runWon);
				this.flow.dispatchUpdate(Update.resetProgress);
			}
			else
				this.labelContainer.addChild(this.roundWon);
			
			this.update::gameOver();
		}
	}

}