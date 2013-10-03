package game.hud 
{
	import game.data.IGame;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class GlobalMap extends Sprite
	{
		private var regularBeacon:Quad;
		private var map:QuadBatch;
		
		public function GlobalMap() 
		{
			this.x = this.y = 100;
			
			this.regularBeacon = new Quad(10, 10, 0);
			
			this.map = new QuadBatch();
			this.addChild(this.map);
		}
		
		internal function draw(state:IGame):void
		{
			this.map.reset();
			
			//TODO: draw
		}
	}

}