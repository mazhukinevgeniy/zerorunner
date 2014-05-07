package 
{
	import assets.AssetLoader;
	import binding.Binder;
	import controller.ControllerElements;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import model.ModelElements;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import view.utils.SoftStarling;
	import view.ViewElements;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends flash.display.Sprite 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public static const FPS:int = 60;
		//TODO: why is it here?
		
		private var mStarling:SoftStarling;
		
		private var starlingRoot:starling.display.Sprite;
		
		private var binder:Binder;
		private var modelElements:ModelElements;
		private var controllerElements:ControllerElements;
		private var viewElements:ViewElements;
		//private var game:GameElements;
		//private var shell:Shell;
		//private var listener:EventListener;
		//TODO: check if we need anything here
		
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
			
			
			new AssetLoader(this);
		}
		
		public function initializeEverything(assets:AssetManager):void
		{
			this.binder = new Binder();
			
			this.binder.addBindable(this.assets = assets, AssetManager);
			
			
			this.modelElements = new ModelElements(this.binder);
			this.controllerElements = new ControllerElements(this.binder);
			this.viewElements = new ViewElements(this.binder, this.starlingRoot);
			
			
			//this.game = new GameElements(this.assets);
			
			//this.starlingRoot.addChild((this.game).displayRoot);
			
			//this.shell = new Shell(this.starlingRoot, this.game);
			//this.listener = new EventListener(this.game, Starling.current.nativeStage);
			
			this.binder.triggerBinding();
			
			Starling.current.stage.color = Game.STAGE_COLOR;
			
			//TODO: finish the rework
		}
	}

}