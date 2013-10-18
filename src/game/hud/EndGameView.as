package game.hud 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class EndGameView extends Sprite
	{
		private var flow:IUpdateDispatcher;
		
		
		private var text:Label;
		
		private var globalMap:GlobalMap;
		
		
		public function EndGameView(foundations:GameFoundations) 
		{
			super();
			
			this.text = new Label();
			this.addChild(this.text);
			
			
			var button:Button = new Button();
			button.label = "Quit";
			button.x = 60;
			button.y = 60;
			button.nameList.add(ExtendedTheme.BUTTON_MENU);
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			this.addChild(button);
			
			
			this.globalMap = new GlobalMap(foundations.config);
			this.addChild(this.globalMap);
			
			
			this.flow = foundations.flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
			this.flow.addUpdateListener(Update.gameFinished);
			
			foundations.displayRoot.addChild(this);
		}
		
		update function restore():void
		{
			this.visible = false;
		}
		
		update function gameFinished(key:int):void
		{
			if (key != Game.ABANDONED)
			{
				this.visible = true;
				this.globalMap.redraw();
				
				if (key == Game.WON)
				{
					this.text.text = "You win";
				}
				else if (key == Game.LOST)
				{
					
				}
			}
		}
		
		
		
		private function handleQuitTriggered():void
		{
			this.flow.dispatchUpdate(Update.quitGame);
		}
	}

}