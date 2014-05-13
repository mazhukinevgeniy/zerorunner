package assets 
{
	import assets.xml.AtlasXML;
	import assets.xml.FontXML;
	import flash.ui.Keyboard;
	import native_controls.ProgressBar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
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
				
				var atlas:TextureAtlas = this.assetManager.getTextureAtlas(View.MAIN_ATLAS);
				
				this.addFonts(atlas);
				
				this.boss.initializeEverything(this.assetManager);
			}
		}
		
		private function removeAll():void
		{
			this.boss.removeChild(this.progressBar);
			this.progressBar = null;
		}
		
		
		private function addFonts(atlas:TextureAtlas):void
		{
			TextField.registerBitmapFont(new BitmapFont(
					atlas.getTexture("FantasqueSansMono"), 
					FontXML.getFantasqueSansMonoXML()),
					"FantasqueSansMono");
			
			var bbxml:XML = FontXML.getBananaBrickXML();
			
			for each (var char:XML in bbxml.chars.char)
			{
				if (parseInt(char.@id) != Keyboard.SPACE)
					char.@xadvance = (parseInt(char.@xoffset) + parseInt(char.@width));
			}
			
			TextField.registerBitmapFont(new BitmapFont(atlas.getTexture("BananaBrick"), bbxml),
				                         "BananaBrick");
		}
	}

}