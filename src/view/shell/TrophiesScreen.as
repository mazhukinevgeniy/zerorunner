package view.shell 
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	internal class TrophiesScreen extends Screen
	{
		//TODO: the plan is to have, like, a road of achievements.
		// a road which is forked in many places.
		// like, a tree.
		
		public function TrophiesScreen() 
		{
			super();
			
			
			
			var quit:Button = createButton("BACK");
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}

}