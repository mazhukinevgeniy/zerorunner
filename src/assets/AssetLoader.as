package assets 
{
	import assets.xml.AtlasXML;
	import native_controls.ProgressBar;
	import starling.utils.AssetManager;
	
	public class AssetLoader 
	{
		private var boss:Main;
		private var assetManager:AssetManager;
		
		private var progressBar:ProgressBar;
		
		public function AssetLoader(boss:Main) 
		{
			this.progressBar = new ProgressBar();
			
			boss.addChild(this.progressBar);
			
			this.boss = boss;
			
			this.assetManager = new AssetManager();
			
			this.assetManager.verbose = true;
			this.assetManager.enqueue(EmbeddedAssets);
			
			this.assetManager.loadQueue(this.assetsProgress);
		}
		
		
		private function assetsProgress(ratio:Number):void
		{
			this.progressBar.redraw(ratio);
			
			if (ratio == 1.0)
			{
				this.removeAll();
				
				initializeAtlasMakerAtlases(this.assetManager, AtlasXML.getOne());
				
				this.boss.initializeEverything(this.assetManager);
			}
		}
		
		private function removeAll():void
		{
			this.boss.removeChild(this.progressBar);
			this.progressBar = null;
		}
	}

}