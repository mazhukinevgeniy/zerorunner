package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import view.themes.GameTheme;
	import view.utils.createButton;
	
	internal class EndGameScreen extends Screen
	{
		private var controller:IGameController;
		
		public function EndGameScreen(binder:IBinder, ending:int) 
		{
			super();
			
			
			this.setLayout();
			this.controller = binder.gameController;
			
			
			var text:Label = new Label();
			
			if (ending == Game.ENDING_WON)
			{
				text.text = "YOU WIN";
			}
			else if (ending == Game.ENDING_LOST)
			{
				text.text = "YOU LOSE";
			}
			
			
			var button:Button = createButton("QUIT", GameTheme.MENU_BUTTON);
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			
			
			this.addChild(text);
			this.addChild(button);
		}
		
		private function setLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = 20;
			
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		
		
		private function handleQuitTriggered():void
		{
			this.controller.quitGame();
		}
	}

}