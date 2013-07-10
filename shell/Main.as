package 
{
	import flash.display.Sprite;
	import flash.ui.ContextMenu;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.display.Sprite;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends flash.display.Sprite 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public static const PROJECT_NAME:String = "zeroRunner";
		
		
		private var mStarling:Starling;
		private var master:MasterChaotic;
		
		private var newContextMenu:ContextMenu;
		
		
		public function Main()
		{ 	
			this.newContextMenu = new ContextMenu();
			this.newContextMenu.hideBuiltInItems();
			this.contextMenu = this.newContextMenu;
		}
		
		internal function initialize():void 
		{
			Starling.handleLostContext = true;
			
			this.mStarling = new Starling(starling.display.Sprite, this.stage);
			this.mStarling.simulateMultitouch = false;
			this.mStarling.enableErrorChecking = Capabilities.isDebugger;
			this.mStarling.start();
			
			this.mStarling.showStats = true;
			this.mStarling.showStatsAt("left", "bottom");
			
			this.mStarling.addEventListener(Event.ROOT_CREATED, this.handleRootCreated);
		}
		
		private function handleRootCreated(event:Event):void
		{
			this.mStarling.removeEventListener(Event.ROOT_CREATED, this.handleRootCreated);
			
			if (this.mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
			{
				this.mStarling.nativeStage.frameRate = 30;
				trace("GPU is out of business!");
			}
			
			this.master = new MasterChaotic(event.data as DisplayObjectContainer);
		}
	}

}