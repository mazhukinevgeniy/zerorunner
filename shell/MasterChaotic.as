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
		public static const flowName:String = "Master Flow";
		
		
		private var root:DisplayObjectContainer;
		private var assets:AssetManager;
		
		public function MasterChaotic(root:DisplayObjectContainer, assets:AssetManager) 
		{
			super(MasterChaotic.flowName);
			
			
			this.root = root;
			this.assets = assets;
			
			
			new ChaoticUI(root, this.assets);
			/*
			var view:View = new View(this);
			
			var game:ZeroRunner = new ZeroRunner((view).getGameContainer(), (view).getAssets());
			
			var model:Data = new Data(game);
			*/
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticUI.flowName, ChaoticUI.keyUp, event.keyCode);
		}
	}

}