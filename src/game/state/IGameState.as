package game.state 
{
	
	public interface IGameState 
	{
		function get ticksPassed():uint;
		
		/**
		 * Half-width of the actor cache.
		 */
		function get xDistanceActorsAllowed():int;
		/**
		 * Half-height of the actor cache.
		 */
		function get yDistanceActorsAllowed():int;
		
		
		/**
		 * Half-width of the scene cache.
		 */
		function get xDistanceSceneAllowed():int;
		/**
		 * Half-height of the scene cache.
		 */
		function get yDistanceSceneAllowed():int;
	}
	
}