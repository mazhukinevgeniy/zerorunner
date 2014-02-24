package game.forceFields 
{
	import data.viewers.GameConfig;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ForceFields implements IForceField
	{
		private var generators:Vector.<Boolean>;
		
		private const width:int = Game.MAP_WIDTH / 15;
		
		public function ForceFields(flow:IUpdateDispatcher) 
		{
			if (Game.MAP_WIDTH % 15 != 0)
				throw new Error("temporary forcefield solution is incompatible with this map width");
			
			this.generators = new Vector.<Boolean>(this.width * this.width, true);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.generatorPowered);
		}
		
		update function restore(config:GameConfig):void
		{
			for (var i:int = 0; i < this.width * this.width; i++)
				this.generators[i] = false;
		}
		
		update function generatorPowered(x:int, y:int):void
		{
			x /= 15; 
			y /= 15;
			
			this.generators[x + y * this.width] = true;
		}
		
		
		public function isCellCovered(x:int, y:int):Boolean
		{
			x = normalize(x);
			y = normalize(y);
			
			var mX:int = x % 15;
			var mY:int = y % 15;
			
			if (mX > 7)
				x = (((x - mX) / 15) + 1 + this.width) % this.width;
			else
				x = ((x - mX) / 15);
			
			if (mY > 7)
				y = (((y - mY) / 15) + 1 + this.width) % this.width;
			else
				y = ((y - mY) / 15);
			
			return this.generators[x + y * this.width];
		}
	}

}