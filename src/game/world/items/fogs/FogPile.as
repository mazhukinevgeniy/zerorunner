package game.world.items.fogs 
{
	import game.core.GameFoundations;
	import game.core.metric.CellXY;
	import game.core.metric.Metric;
	import game.world.IActorTracker;
	import game.world.items.ItemLogicBase;
	
	internal class FogPile extends ItemLogicBase
	{
		private var actors:IActorTracker;
		
		public function FogPile(foundations:GameFoundations) 
		{
			this.actors = foundations.actors;
			
			super(new FogPileView(this, foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(0, 0);
		}
		
		override public function applyDestruction():void
		{
			this.actors.removeActor(this);
		}
	}

}