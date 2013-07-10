package  
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import flash.events.KeyboardEvent;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	internal class MasterChaotic extends UpdateManager
	{
		private var root:DisplayObjectContainer;
		private var assets:AssetManager;
		
		public function MasterChaotic(root:DisplayObjectContainer, assets:AssetManager) 
		{
			this.root = root;
			this.assets = assets;
			
			new ChaoticUI(root, this, this.assets);
			/*
			 * 
			 * 
			var view:View = new View(this);
			
			var game:ZeroRunner = new ZeroRunner((view).getGameContainer(), (view).getAssets());
			
			var model:Data = new Data(game);
			 * 
			 */
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.dispatchUpdate(ChaoticUI.keyUp, event.keyCode);
		}
	}

}