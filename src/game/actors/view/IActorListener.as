package game.actors.view 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	public interface IActorListener 
	{
		function setLayerOf(id:int, layer:int):void;
		
		
		
		/**
		 * MOVING CUSTOMIZATION
		**/
		
		/**
		 * Call if actor jumps.
		 * 
		 * @param delay Produced cooldown. 
		 * If not interrupted, that's how many ticks sprite will be moving to its next position.
		**/
		function actorJumped(id:int, change:DCellXY, delay:int):void;
	}
	
}