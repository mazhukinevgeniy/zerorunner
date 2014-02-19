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
		}
		
		update function restore(config:GameConfig):void
		{
			for (var i:int = 0; i < this.width * this.width; i++)
				this.generators[i] = false;
		}
		
		
		
		public function isCellCovered(x:int, y:int):Boolean
		{
			x = normalize(x);
			y = normalize(y);
			
			var mX:int = x % 15;
			var mY:int = y % 15;
			
			if (mX > 7)
				x = (x / 15) + 1;
			else
				x = (x / 15);
			
			if (mY > 7)
				y = (y / 15) + 1;
			else
				y = (y / 15);
			
			return this.generators[x + y * this.width];
		}
	}

}