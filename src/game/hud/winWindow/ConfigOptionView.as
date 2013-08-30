package game.hud.winWindow 
{
	import feathers.controls.Label;
	import game.core.GameFoundations;
	import game.IGame;
	import game.utils.RandomGameState;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.textures.Texture;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ConfigOptionView extends Button
	{
		private var flow:IUpdateDispatcher;
		private var game:IGame;
		
		private var newConfig:RandomGameState;
		
		private var label:Label;
		
		public function ConfigOptionView(foundations:GameFoundations) 
		{
			super(Texture.fromColor(150, 40, 0xFF999999));
			
			this.flow = foundations.flow;
			this.game = foundations.game;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.gameWon);
			
			this.addChild(this.label = new Label());
		}
		
		internal function activate():void
		{
			this.flow.dispatchUpdate(Update.reparametrize, this.newConfig);
			
			this.alpha = 1;
		}
		
		internal function deactivate():void
		{
			this.alpha = 0.5;
			//TODO: do it normal way
		}
		
		update function gameWon():void
		{
			this.newConfig = new RandomGameState(this.game);
			
			this.label.text = "sectors per row: " + String(this.newConfig.mapWidth);
		}
	}

}