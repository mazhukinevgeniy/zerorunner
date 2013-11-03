package game.items.utils 
{
	import game.items.Items;
	import game.points.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	
	public class ItemUtils 
	{
		private static var created:int = 0;
		
		public function ItemUtils(items:Items, flow:IUpdateDispatcher, points:IPointCollector, itemsArray:Array) 
		{
			ItemUtils.created++;
			if (ItemUtils.created > 1)
				throw new Error();
			
			new Advance(itemsArray, flow);
			new Act(items, flow, points);
			new Clear(items, flow);
		}
		
	}

}