package game.items 
{
	import game.core.metric.DCellXY;
	import game.items.base.ItemBase;
	
	public interface IActorTracker 
	{
		function addActor(item:ItemBase):void;
		
		function moveActor(actor:ItemBase, change:DCellXY):void;
		
		function removeActor(actor:ItemBase):void;
		
		//TODO: check if it wouldn't be better if based on updates
		//TODO: alternate way is to check if we can abuse internality
	}
	
}