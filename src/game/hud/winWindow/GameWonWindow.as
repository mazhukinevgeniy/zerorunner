package game.hud.winWindow 
{
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.hud.GameOverWindow;
	import game.IGame;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class GameWonWindow extends GameOverWindow
	{
		private var leftButton:ConfigOptionView;
		private var rightButton:ConfigOptionView;
		
		public function GameWonWindow(foundations:GameFoundations) 
		{
			this.leftButton = new ConfigOptionView(foundations);
			this.rightButton = new ConfigOptionView(foundations);
			
			this.leftButton.addEventListener(Event.TRIGGERED, this.handleConfigButtonTriggered);
			this.rightButton.addEventListener(Event.TRIGGERED, this.handleConfigButtonTriggered);
			
			super(foundations.flow);
		}
		
		override protected function addMessage(message:DisplayObjectContainer):void
		{
			var tmp:Label = new Label();
			tmp.text = "You win";
			
			tmp.x = 20;
			tmp.y = 20;
			
			message.addChild(tmp);
			
			message.addChild(this.leftButton);
			message.addChild(this.rightButton);
			
			this.rightButton.x = 2 * this.rightButton.width;
		}
		
		override protected function addUpdateListeners(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.gameWon);
		}
		
		private function handleConfigButtonTriggered(event:Event):void
		{
			var target:ConfigOptionView = event.target as ConfigOptionView;
			
			target.activate();
			
			if (target == this.leftButton)
				this.rightButton.deactivate();
			else
				this.leftButton.deactivate();
		}
		
		update function gameWon():void
		{
			this.rightButton.deactivate();
			this.leftButton.activate();
			
			this.update::gameOver();
		}
	}

}