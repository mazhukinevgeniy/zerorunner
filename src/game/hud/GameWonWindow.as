package game.hud 
{
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.hud.GameOverWindow;
	import game.IGame;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class GameWonWindow extends GameOverWindow
	{
		private var game:IGame;
		
		private var roundWon:Label;
		private var runWon:Label;
		
		private var labelContainer:Sprite;
		
		private var globalMap:GlobalMap;
		
		public function GameWonWindow(foundations:GameFoundations) 
		{
			this.game = foundations.game;
			
			this.globalMap = new GlobalMap();
			
			this.roundWon = new Label();
			this.roundWon.text = "You win!";
			
			this.runWon = new Label();
			this.runWon.text = "You win! Run is finished!";
			
			super(foundations.flow);
			
			//TODO: remove it
		}
		
		override protected function addMessage(message:DisplayObjectContainer):void
		{
			this.labelContainer = new Sprite();
			
			this.labelContainer.x = 20;
			this.labelContainer.y = 20;
			
			message.addChild(this.labelContainer);
			
			message.addChild(this.globalMap);
		}
		
		override protected function addUpdateListeners(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.tellGameWon);
			flow.addUpdateListener(Update.tellRoundWon);
		}
		
		update function tellRoundWon():void
		{
			this.labelContainer.removeChildren();
			this.labelContainer.addChild(this.roundWon);
			
			this.globalMap.draw(this.game);
			
			this.update::gameOver();
		}
		
		update function tellGameWon():void
		{
			this.labelContainer.removeChildren();
			this.labelContainer.addChild(this.runWon);
			
			this.globalMap.draw(this.game);
			
			this.update::gameOver();
		}
	}

}