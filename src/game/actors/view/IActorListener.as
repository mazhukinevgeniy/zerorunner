package game.actors.view 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	public interface IActorListener 
	{
		function setLayerOf(id:int, layer:int):void;
		
		
		
		/**
		 * MOVING OPTIONS
		**/
		
		
		/**
		 * Call if actor takes its typical move (human walks, helicopter flies etc).
		 * 
		 * @param delay Produced cooldown. 
		 * If not interrupted, that's how many ticks sprite will be moving to its next position.
		**/
		function actorMovedNormally(id:int, goal:CellXY, change:DCellXY, delay:int):void; 
		
		/**
		 * Call if actor jumps.
		 * 
		 * @param delay Produced cooldown. 
		 * If not interrupted, that's how many ticks sprite will be moving to its next position.
		**/
		function actorJumped(id:int, change:DCellXY, delay:int):void;
		
		
		
		
		/**
		 * DESTROYING OPTIONS
		**/
		
		
		/**
		 * Call if want to unshow something immediately.
		**/
		function unparent(id:int):void;
	}
	
}