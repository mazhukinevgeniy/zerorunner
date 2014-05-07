package controller 
{
	import game.input.InputCollector;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var inputCollector:InputCollector;
		private var restorer:Restorer;
		
		public function GameUpdateConverter(elements:GameElements) 
		{
			var flow:IUpdateDispatcher = elements.flow;
			
			this.inputCollector = elements.inputCollector;
			this.restorer = elements.restorer;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.toggleMap);
			flow.addUpdateListener(Update.handleDeactivation);
			flow.addUpdateListener(Update.setVisibilityOfGameMenu);
		}
		
		
		update function newGame():void
		{
			this.restorer.triggerRestore();
			
			this.inputCollector.clearInput();
		}
		
		update function toggleMap():void
		{
			this.inputCollector.clearInput();
		}
		
		update function handleDeactivation():void
		{
			this.inputCollector.clearInput();
		}
		
		update function setVisibilityOfGameMenu(visible:Boolean):void
		{
			this.inputCollector.clearInput();
		}
	}

}