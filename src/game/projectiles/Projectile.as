package game.projectiles 
{
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public class Projectile 
	{
		private var _type:int;
		private var _cell:CellXY;
		
		private var _height:int;
		private var _speed:int;
		
		private var controller:ProjectileController;
		
		public function Projectile(controller:ProjectileController, type:int, x:int, y:int) 
		{
			this.controller = controller;
			
			this._cell = new CellXY(0, 0);
			
			this.reassign(type, x, y);
		}
		
		internal function reassign(type:int, x:int, y:int):void
		{
			this._type = type;
			
			this._cell.setValue(x, y);
			
			this._height = Game.MAX_PROJ_HEIGHT;
			this._speed = 1;
			
			this.controller.launchProjectile(this);
		}
		
		internal function advance():void
		{
			this._height -= this._speed;
			
			if (this._height <= 0)
			{
				this.controller.landProjectile(this);
			}
		}
		
		public function get type():int { return this._type; }
		public function get cell():ICoordinated { return this._cell; }
		public function get height():int { return this._height; }
	}

}