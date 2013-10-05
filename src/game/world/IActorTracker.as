package game.world 
{
	import game.core.metric.DCellXY;
	import game.world.items.utils.ItemLogicBase;
	
	public interface IActorTracker 
	{
		function addActor(item:ItemLogicBase):void;
		
		function moveActor(actor:ItemLogicBase, change:DCellXY):void;
		
		function removeActor(actor:ItemLogicBase):void;
	}
	
}