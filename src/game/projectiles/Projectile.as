package game.projectiles 
{
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	
	public class Projectile 
	{
		private var _type:int;
		private var _cell:CellXY;
		
		private var _height:int;
		private var _speed:int;
		
		private var flow:IUpdateDispatcher;
		
		public function Projectile(flow:IUpdateDispatcher, type:int, x:int, y:int) 
		{
			this.flow = flow;
			
			
			this._type = type;
			this._cell = new CellXY(x, y);
			
			this._height = 10;
			this._speed = 1;
		}
		
		internal function reassign(type:int, x:int, y:int):void
		{
			this._type = type;
			
			this._cell.setValue(x, y);
			
			this._height = 10;
			this._speed = 1;
		}
		
		internal function advance():void
		{
			this._height -= this._speed;
			
			if (this._height == 0)
			{
				this.onLanded();
				this.flow.dispatchUpdate(Update.projectileLanded, this);
			}
		}
		
		private function onLanded():void
		{
			if (this.type == 0)
			{
				
			}
			else if (false)//TODO: write landing mechanics here, why not
			{
				
			}
		}
		
		public function get type():int { return this._type; }
		public function get cell():ICoordinated { return this._cell; }
	}

}