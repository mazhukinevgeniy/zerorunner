package game.items 
{
	import game.core.metric.DCellXY;
	
	public interface IActorTracker 
	{
		function addActor(item:ItemLogicBase):void;
		
		function moveActor(actor:ItemLogicBase, change:DCellXY):void;
		
		function removeActor(actor:ItemLogicBase):void;
		
		//TODO: check if it wouldn't be better if based on updates
		//TODO: alternate way is to check if we can abuse internality
	}
	
}