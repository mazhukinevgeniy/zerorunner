package model.items.concrete 
{
	import binding.IBinder;
	import model.items.ItemBase;
	import model.items.Items;
	import model.metric.ICoordinated;
	
	internal class PassiveItem extends ItemBase
	{
		private var _type:int;
		
		public function PassiveItem(type:int, items:Items, binder:IBinder, cell:ICoordinated) 
		{
			super(items, binder, cell);
			
			this._type = type;
		}
		
		override public function get type():int 
		{
			return this._type;
		}
		
		override protected function get isDestructible():Boolean 
		{
			return false;
		}
	}

}