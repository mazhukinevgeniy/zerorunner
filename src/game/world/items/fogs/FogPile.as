package game.world.items.fogs 
{
	import game.core.GameFoundations;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.Metric;
	import game.world.items.IPushable;
	import game.world.items.ItemLogicBase;
	
	internal class FogPile extends ItemLogicBase implements IPushable
	{
		
		public function FogPile(foundations:GameFoundations) 
		{
			
			super(new FogPileView(this, foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(0, 0);
		}
		
		//TODO: in case 0, 0 is visible make the fog invisible until used OR just fill the bounds with the maximum fog view, lol
		
		/**
		 * 
		 */
		
		public function applyPush(change:DCellXY):void
		{
			//TODO: make it flow
			
			/*
			 * if next is empty, move itself;
			 * else if next is fog, animate something and give extra fog pieces to that guy;
			 * else if next is an obstacle, flow around
			 */
		}
	}

}