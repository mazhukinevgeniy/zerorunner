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
			
			this.regularBeacon = new Quad(10, 10, 0x00FFFF);
			
			this.map = new QuadBatch();
			this.addChild(this.map);
		}
		
		internal function draw(state:IGame):void
		{
			this.map.reset();
			
			for (var i:int = 0; i < Game.LEVELS_PER_RUN; i++)
			{
				if (state.getBeacon(i) == Game.BEACON)
				{
					this.regularBeacon.x = i * 20;
					
					this.map.addQuad(this.regularBeacon);
					
					//TODO: make it beautiful
				}
			}
		}
	}

}