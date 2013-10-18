package game.hud.tmp 
{
	import data.viewers.GameConfig;
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.hud.GameOverWindow;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	//TODO: remove dat stupid inheretance
	public class GameWonWindow extends GameOverWindow
	{
		
		private var roundWon:Label;
		private var runWon:Label;
		
		private var labelContainer:Sprite;
		
		
		public function GameWonWindow(foundations:GameFoundations) 
		{
			
			
			this.roundWon = new Label();
			this.roundWon.text = "You win!";
			
			this.runWon = new Label();
			this.runWon.text = "You win! Run is finished!";
			
			super(foundations);
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
			flow.addUpdateListener(Update.tellGameWon);
			flow.addUpdateListener(Update.tellRoundWon);
		}
		
		update function tellRoundWon(progress:GameConfig):void
		{
			this.labelContainer.removeChildren();
			this.labelContainer.addChild(this.roundWon);
		}
		
		update function tellGameWon(progress:GameConfig):void
		{
			this.labelContainer.removeChildren();
			this.labelContainer.addChild(this.runWon);
		}
	}

}