package starling.tweaks 
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.Event;
	
	internal class SoftStarling extends Starling
	{
		private var isSoft:Boolean;
		
		private var frameToDraw:Boolean = false;
		
		public function SoftStarling(rootClass:Class, stage:Stage, 
									 viewPort:Rectangle=null, stage3D:Stage3D=null,
									 renderMode:String="auto", profile:String="baselineConstrained") 
		{
			super(rootClass, stage, viewPort, stage3D, renderMode, profile);
			
			this.addEventListener(Event.ROOT_CREATED, this.handleRootCreated);
		}
		
		private function handleRootCreated(event:Event):void
		{
			this.removeEventListener(Event.ROOT_CREATED, this.handleRootCreated);
			
			this.isSoft = this.context.driverInfo.toLowerCase().indexOf("software") != -1;
		}
		
		override public function render():void
		{
			this.frameToDraw = !this.frameToDraw;
			
			if (!this.isSoft || this.frameToDraw)
			{
				super.render();
			}
		}
	}

}