package starling 
{
	import assets.AssetLoader;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingStarter 
	{
		private var starlingInstance:Starling;
		private var boss:Main;
		
		public var starlingRoot:Sprite;
		
		public function StarlingStarter(boss:Main) 
		{
			this.boss = boss;
			
			
			Starling.handleLostContext = true;
			
			this.starlingInstance = new SoftStarling(Sprite, this.boss.stage);
			this.starlingInstance.simulateMultitouch = false;
			this.starlingInstance.enableErrorChecking = Capabilities.isDebugger;
			this.starlingInstance.start();
			
			this.starlingInstance.showStats = true;
			this.starlingInstance.showStatsAt("right", "top");
			
			this.starlingInstance.addEventListener(Event.ROOT_CREATED, this.handleRootCreated);
		}
		
		private function handleRootCreated(event:Event):void
		{
			this.starlingInstance.removeEventListener(Event.ROOT_CREATED, this.handleRootCreated);
			
			this.starlingRoot = event.data as Sprite;
			
			this.starlingInstance.stage.color = Game.STAGE_COLOR;
			FocusManager.isEnabled = false;
			/**
			 * IF we have keyboard user, we give him hotkeys.
			 * It's, like, caring about keyboard user or NOT caring about extra sprites.
			 */
			FeathersControl.defaultTextRendererFactory = this.getTextRenderer;
			
			new AssetLoader(this.boss);
		}
		
		private function getTextRenderer():PreciseBitmapFontTextRenderer
		{
			return new PreciseBitmapFontTextRenderer();
		}
	}

}