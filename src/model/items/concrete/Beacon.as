package model.items.concrete 
{
	import binding.IBinder;
	import model.items.ItemBase;
	import model.items.Items;
	import model.metric.ICoordinated;
	
	internal class Beacon extends ItemBase
	{
		
		public function Beacon(items:Items, binder:IBinder, cell:ICoordinated) 
		{
			super(items, binder, cell);
		}
		
		override public function get type():int { return Game.ITEM_BEACON; }
	}

}