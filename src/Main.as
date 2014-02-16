package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import game.GameElements;
	import hotkeys.Hotkeys;
	import preloader.ProgressBar;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.Shell;
	import utils.AtlasXML;
	import utils.initializeAtlasMakerAtlases;
	import utils.SoftStarling;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends flash.display.Sprite 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public static const FPS:int = 60;
		
		
		private var mStarling:SoftStarling;
		
		private var starlingRoot:starling.display.Sprite;
		
		private var game:GameElements;
		private var shell:Shell;
		private var hotkeys:Hotkeys;
		
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
				
				initializeAtlasMakerAtlases(this.assets, AtlasXML.getOne());
				
				this.game = new GameElements(this.assets);
				this.shell = new Shell(this.starlingRoot, this.game);
				this.hotkeys = new Hotkeys(this.game, Starling.current.nativeStage);
				
				Starling.current.stage.color = 0;
			}
		}
		
	}

}