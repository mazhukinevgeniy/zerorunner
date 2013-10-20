package game.world.clouds 
{
	import flash.events.Event;
	import starling.core.Starling;
	import starling.extensions.krecha.ScrollTile;
	import starling.textures.Texture;
	
	internal class Cloud extends ScrollTile
	{
		private var dX:int;
		private var dY:int;
		
		public function Cloud(texture:Texture)
		{
			do
			{
				this.dX = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
				this.dY = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
			}
			while (this.dX == 0 && this.dY == 0);
			
			super(texture);
			
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
		}
		
		internal function die():void
		{
			Starling.current.nativeStage.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
		}
		
		private function handleEnterFrame(event:Event):void
		{
			this.offsetX = int(this.offsetX + this.dX);
			this.offsetY = int(this.offsetY + this.dY);
		}
	}

}