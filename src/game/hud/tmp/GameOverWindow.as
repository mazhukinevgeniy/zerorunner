package game.hud.tmp 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.ZeroRunner;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class GameOverWindow
	{
		private var message:Sprite;
		private var flow:IUpdateDispatcher;
		
		public function GameOverWindow(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.message = new Sprite();
			
			var tmpI:Quad = new Quad(400, 200, 0x222222);
			tmpI.alpha = 0.7;
			this.message.addChild(tmpI);
			
			this.message.x = (Main.WIDTH - this.message.width) / 2;
			this.message.y = (Main.HEIGHT - this.message.height) / 2;
			
			this.addMessage(this.message);
			
			var button:Button = new Button();
			button.label = "Quit";
			
			button.x = 60;
			button.y = 60;
			
			button.nameList.add(ExtendedTheme.BUTTON_MENU);
			
			button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			
			this.message.addChild(button);
			
			this.addUpdateListeners(flow);
		}
		
		protected function addMessage(message:DisplayObjectContainer):void
		{
			var tmp:Label = new Label();
			tmp.text = "Game over";
			
			tmp.x = 20;
			tmp.y = 20;
			
			message.addChild(tmp);
		}
		
	}

}