package game.world 
{
	import game.utils.metric.DCellXY;
	import game.world.broods.ItemLogicBase;
	
	public interface IActorTracker 
	{
		function addActor(item:ItemLogicBase):void;
		
		function moveActor(actor:ItemLogicBase, change:DCellXY, delay:int):void;
		
		function removeActor(actor:ItemLogicBase):void;
	}
	
}