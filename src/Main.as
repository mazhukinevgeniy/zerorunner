package 
{
	import data.DatabaseManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.system.Capabilities;
	import game.GameElements;
	import preloader.ProgressBar;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import ui.Shell;
	import utils.adaptTextureAtlasMakerXML;
	import utils.SoftStarling;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends flash.display.Sprite 
	{
		[Embed(source = "../res/assets/textures/atlases/gameatlas.xml", mimeType="application/octet-stream")]
		internal static const gameatlas:Class; 
		
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public static const FPS:int = 60;
		
		
		private var mStarling:SoftStarling;
		
		private var starlingRoot:starling.display.Sprite;
		private var game:GameElements;
		private var shell:Shell;
		
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
			
			this.mStarling = new SoftStarling(starling.display.Sprite, this.stage);
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
				
				var flow:UpdateManager = new UpdateManager();
				var database:DatabaseManager = new DatabaseManager(flow);
				
				
				var gameRoot:starling.display.Sprite = new starling.display.Sprite();
				
				this.game = new GameElements(flow, database, this.assets, gameRoot);
				this.shell = new Shell(this.starlingRoot, database, this.game);
				
				Starling.current.stage.color = 0;
			}
		}
		
	}

}