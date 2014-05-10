package 
{
	import binding.Binder;
	import controller.ControllerElements;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import model.ModelElements;
	import starling.extensions.TextureAtlasLogger;
	import starling.tweaks.StarlingStarter;
	import starling.utils.AssetManager;
	import view.ViewElements;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		private var starlingStarter:StarlingStarter;
		
		private var binder:Binder;
		private var modelElements:ModelElements;
		private var controllerElements:ControllerElements;
		private var viewElements:ViewElements;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.initializeNative);
		}
		
		private function initializeNative(event:Event):void 
		{
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, this.initializeNative);
			
			this.starlingStarter = new StarlingStarter(this);
		}
		
		public function initializeEverything(assets:AssetManager):void
		{
			this.binder = new Binder();
			
			this.binder.addBindable(assets, AssetManager);
			
			this.controllerElements = new ControllerElements(this.binder);
			this.modelElements = new ModelElements(this.binder);
			this.viewElements = new ViewElements(this.binder, this.starlingStarter.starlingRoot);
			
			this.binder.triggerBinding();
			
			(assets.getTextureAtlas("sprites") as TextureAtlasLogger).tellWhatIsNeverRequested();
		}
	}

}