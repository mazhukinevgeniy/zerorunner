package game.hud.winWindow 
{
	import game.core.GameFoundations;
	import game.IGame;
	import game.utils.RandomGameState;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ConfigOptionView extends Sprite
	{
		private var flow:IUpdateDispatcher;
		private var game:IGame;
		
		private var newConfig:RandomGameState;
		
		public function ConfigOptionView(foundations:GameFoundations) 
		{
			this.flow = foundations.flow;
			this.game = foundations.game;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.gameWon);
		}
		
		internal function activate():void
		{
			this.flow.dispatchUpdate(Update.reparametrize, this.newConfig);
			
			//TODO: show it somehow
		}
		
		internal function deactivate():void
		{
			//TODO: unshow the possible activation
		}
		
		update function gameWon():void
		{
			this.newConfig = new RandomGameState(this.game);
		}
	}

}