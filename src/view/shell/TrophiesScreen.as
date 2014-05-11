package view.shell 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	internal class TrophiesScreen extends Screen
	{
		
		public function TrophiesScreen() 
		{
			super();
			
			
			var placeHolder1:Label = new Label();
			placeHolder1.text = "THIS WILL BE DONE"; 
			
			var placeHolder2:Label = new Label();
			placeHolder2.text = "WHEN THE GAME IS DONE"; 
			
			
			
			var quit:Button = createButton("BACK");
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			
			this.addChild(placeHolder1);
			this.addChild(placeHolder2);
			this.addChild(quit);
		}
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}

}