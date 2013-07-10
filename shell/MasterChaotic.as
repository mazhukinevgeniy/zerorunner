package  
{
	import chaotic.core.Chaotic;
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	internal class MasterChaotic extends Chaotic
	{
		private var root:DisplayObjectContainer;
		private var assets:AssetManager;
		
		public function MasterChaotic(root:DisplayObjectContainer, assets:AssetManager) 
		{
			this.root = root;
			this.assets = assets;
			
			/*
			 * 
			 * 
			var view:View = new View(this);
			
			var game:ZeroRunner = new ZeroRunner((view).getGameContainer(), (view).getAssets());
			
			var model:Data = new Data(game);
			 * 
			 */
		}
		
		override protected function addFeatures():void
		{
			var flow:IUpdateDispatcher = this.updateFlow;
			
			new ChaoticUI(this.root, flow);
			
		}
	}

}