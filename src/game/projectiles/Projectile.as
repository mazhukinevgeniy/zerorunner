package game.projectiles 
{
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	
	public class Projectile 
	{
		private var _type:int;
		private var _cell:CellXY;
		
		public function Projectile(type:int, x:int, y:int) 
		{
			this._type = type;
		}
		
		
		public function get type():int { return this._type; }
		public function get cell():ICoordinated { return this._cell; }
	}

}