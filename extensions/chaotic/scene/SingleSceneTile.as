package chaotic.scene 
{
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	internal class SingleSceneTile extends Image
	{
		private static var pull:TilePull;
		
		private var code:int;
		
		public function SingleSceneTile(texture:Texture, code:int, pull:TilePull) 
		{
			super(texture);
			
			this.code = code;
			this.pull = pull;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
		}
		
		private function onRemoved():void
		{
			this.pull.useTile(this, this.code);
		}
	}

}