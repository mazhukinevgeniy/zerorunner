package game.ui 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import game.GameElements;
	import game.ui.GameTheme;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class EndGameView extends InGameWindowBase
	{
		private var flow:IUpdateDispatcher;
		
		
		private var text:Label;
		
		
		public function EndGameView(elements:GameElements) 
		{
			super(200, 200, elements.assets.getTextureAtlas("sprites"));
			
			
			this.text = new Label();
			this.text.x = 20;
			this.text.y = 20;
			this.addChild(this.text);
			
			
			var button:Button = new Button();
			button.nameList.add(GameTheme.MENU_BUTTON);
			button.nameList.add(GameTheme.QUIT_GAME);
			
			button.x = 60;
			button.y = 60;
			this.addChild(button);
			
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			
			this.flow = elements.flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
			this.flow.addUpdateListener(Update.gameFinished);
			
			elements.displayRoot.addChild(this);
		}
		
		update function restore():void
		{
			this.visible = false;
		}
		
		update function gameFinished(key:int):void
		{
			if (key != Game.ENDING_ABANDONED)
			{
				this.visible = true;
				
				if (key == Game.ENDING_WON)
				{
					this.text.text = "You win!";
				}
				else if (key == Game.ENDING_LOST)
				{
					this.text.text = "You lose!";
				}
			}
		}
		
		private function handleQuitTriggered():void
		{
			this.flow.dispatchUpdate(Update.quitGame);
		}
	}

}