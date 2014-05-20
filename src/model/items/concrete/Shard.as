package model.items.concrete 
{
	import model.items.ItemBase;
	import model.items.structs.ItemParams;
	
	internal class Shard extends ItemBase
	{
		
		public function Shard(params:ItemParams) 
		{
			super(params);
		}
		
		override public function get type():int { return Game.ITEM_SHARD; }
	}

}