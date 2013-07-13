package game.actors.view 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	public interface IActorListener 
	{
		/**
		 * Call if actor is created and finalized (no cell changes out of mechanics etc).
		 * 
		 * @param type Special code which represents what sprite set should be used.
		**/
		function actorSpawned(id:int, cell:CellXY, type:int);
		
		
		
		
		
		
		/**
		 * MOVING OPTIONS
		**/
		
		
		/**
		 * Call if actor takes its typical move (human walks, helicopter flies etc).
		 * 
		 * @param delay Produced cooldown. 
		 * If not interrupted, that's how many ticks sprite will be moving to its next position.
		**/
		function actorMovedNormally(id:int, change:DCellXY, delay:int):void; 
		
		
		
		
		
		
		/**
		 * DESTROYING OPTIONS
		**/
		
		
		/**
		 * Call if want to unshow something immediately:
		 * if it was too far from the character, for example.
		**/
		function actorDisappeared(id:int):void; 
		
		/**
		 * Call if something died because of damage.
		**/
		function actorDeadlyDamaged(id:int):void;
		
		/**
		 * Call if something died because of falling down.
		**/
		function actorFallen(id:int):void;
	}
	
}