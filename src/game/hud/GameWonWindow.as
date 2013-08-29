package game.hud 
{
	import feathers.controls.Label;
	import starling.display.DisplayObjectContainer;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class GameWonWindow extends GameOverWindow
	{
		
		public function GameWonWindow(flow:IUpdateDispatcher) 
		{
			super(flow);
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
			this.update::gameOver();
		}
	}

}