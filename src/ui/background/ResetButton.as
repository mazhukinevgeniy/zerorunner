package ui.background 
{
	public class ResetButton 
	{
		
		public function ResetButton() 
		{
			this.resetButton = ButtonMainMenuFactory.create("Reset progress");
			this.addChild(this.resetButton);
			
			this.resetButton.addEventListener(Event.TRIGGERED, this.handleResetTriggered);
		}
		
	}
	
			
		private function handleResetTriggered():void
		{
			//TODO: tell about the risk. user 'll lose all his droids!
			
			this.flow.dispatchUpdate(Update.resetProgress);
		}

}