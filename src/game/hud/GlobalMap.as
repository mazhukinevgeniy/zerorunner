package game.hud 
{
	import data.viewers.GameConfig;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class GlobalMap extends Sprite
	{
		private var config:GameConfig;
		
		private var regularBeacon:Quad;
		private var map:QuadBatch;
		
		public function GlobalMap(config:GameConfig) 
		{
			this.config = config;
			
			this.x = this.y = 100;
			
			this.regularBeacon = new Quad(10, 10, 0x00FFFF);
			
			this.map = new QuadBatch();
			this.addChild(this.map);
		}
		
		internal function redraw():void
		{
			this.map.reset();
			
			for (var i:int = 0; i < Game.LEVEL_CAP; i++)
			{
				if (this.config.beacon(i + 1) == Game.BEACON)
				{
					this.regularBeacon.x = i * 20;
					
					this.map.addQuad(this.regularBeacon);
					
					//TODO: make it beautiful
				}
			}
		}
	}

}