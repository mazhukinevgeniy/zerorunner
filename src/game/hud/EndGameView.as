package game.hud 
{
	import data.viewers.GameConfig;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import game.GameElements;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class EndGameView extends Sprite
	{
		private var flow:IUpdateDispatcher;
		
		
		private var text:Label;
		
		
		public function EndGameView(elements:GameElements) 
		{
			super();
			
			
			var tmpI:Quad = new Quad(400, 200, 0x222222);
			tmpI.alpha = 0.7;
			this.addChild(tmpI);
			this.x = (Main.WIDTH - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 2;
			
			
			this.text = new Label();
			this.text.x = 20;
			this.text.y = 20;
			this.addChild(this.text);
			
			
			var button:Button = new Button();
			button.label = "Quit";
			button.x = 60;
			button.y = 60;
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			this.addChild(button);
			
			
			
			this.flow = elements.flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
			this.flow.addUpdateListener(Update.gameFinished);
			
			elements.displayRoot.addChild(this);
		}
		
		update function restore(config:GameConfig):void
		{
			this.visible = false;
			//TODO: check if actually needed
		}
		
		update function gameFinished(key:int):void
		{
			if (key != Game.ENDING_ABANDONED)
			{
				this.visible = true;
				
				if (key == Game.ENDING_WON)
				{
					this.text.text = "You win";
				}
				else if (key == Game.ENDING_LOST)
				{
					this.text.text = "You lose";
				}
			}
		}
		
		
		
		private function handleQuitTriggered():void
		{
			this.flow.dispatchUpdate(Update.quitGame);
		}
	}

}