package game.ui 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import game.ZeroRunner;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class GameOverWindow
	{
		private var message:Sprite;
		private var flow:IUpdateDispatcher;
		
		public function GameOverWindow(flow:IUpdateDispatcher) 
		{
			this.message = new Sprite();
			
			var tmpI:Quad = new Quad(200, 200, 0x222222);
			tmpI.alpha = 0.3;
			this.message.addChild(tmpI);
			
			this.message.x = (Main.WIDTH - this.message.width) / 2;
			this.message.y = (Main.HEIGHT - this.message.height) / 2;
			
			var tmp:Label = new Label();
			tmp.text = "Game over";
			
			tmp.x = 20;
			tmp.y = 20;
			
			this.message.addChild(tmp);
			
			var button:Button = new Button();
			button.label = "Quit";
			
			button.x = 60;
			button.y = 60;
			
			button.nameList.add(ExtendedTheme.BUTTON_MAIN_MENU);
			
			button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			
			this.message.addChild(button);
			
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.gameOver);
			
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.message);
			
			this.flow = flow;
		}
		
		private function handleTriggered():void
		{
			this.flow.dispatchUpdate(ZeroRunner.quitGame);
		}
		
		update function restore():void
		{
			this.message.visible = false;
		}
		
		update function gameOver():void
		{
			this.message.visible = true;	
		}
	}

}