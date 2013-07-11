package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.system.Capabilities;
	import game.ZeroRunner;
	import preloader.ProgressBar;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.adaptTextureAtlasMakerXML;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends flash.display.Sprite 
	{
		[Embed(source = "../res/assets/textures/atlases/gameatlas.xml", mimeType="application/octet-stream")]
		internal static const gameatlas:Class; 
		
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public static const PROJECT_NAME:String = "zeroRunner";
		
		
		private var mStarling:Starling;
		
		private var starlingRoot:starling.display.Sprite;
		private var game:ZeroRunner;
		private var ui:ChaoticUI;
		
		private var progressBar:ProgressBar;
		private var assets:AssetManager;
		
		public function Main()
		{ 	
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.initialize);
		}
		
		private function initialize(event:flash.events.Event):void 
		{
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initialize);
			
			Starling.handleLostContext = true;
			
			this.mStarling = new Starling(starling.display.Sprite, this.stage);
			this.mStarling.simulateMultitouch = false;
			this.mStarling.enableErrorChecking = Capabilities.isDebugger;
			this.mStarling.start();
			
			this.mStarling.showStats = true;
			this.mStarling.showStatsAt("right", "top");
			
			this.mStarling.addEventListener(starling.events.Event.ROOT_CREATED, this.handleRootCreated);
		}
		
		private function handleRootCreated(event:starling.events.Event):void
		{
			this.mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, this.handleRootCreated);
			
			if (this.mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
			{
				this.mStarling.nativeStage.frameRate = 30;
				trace("GPU is out of business!");
			}
			
			this.starlingRoot = event.data as starling.display.Sprite;
			
			this.loadAssets();
		}
		
		private function loadAssets():void
		{
			this.progressBar = new ProgressBar();
			this.addChild(this.progressBar);
			
			this.assets = new AssetManager();
			
			this.assets.verbose = true;
			this.assets.enqueue(EmbeddedAssets);
			
			this.assets.loadQueue(this.assetsProgress);
		}
		
		private function assetsProgress(ratio:Number):void
		{
			this.progressBar.redraw(ratio);
			
			if (ratio == 1.0)
			{
				this.removeChild(this.progressBar);
				this.progressBar = null;
				
				this.assets.addTextureAtlas(
						"gameAtlas", 
						new TextureAtlas(
								this.assets.getTexture("sprites0"), 
								adaptTextureAtlasMakerXML(Main.gameatlas)));
			
				this.game = new ZeroRunner(this.assets);
				this.ui = new ChaoticUI(this.starlingRoot, this.assets);
			}
		}
	}

}