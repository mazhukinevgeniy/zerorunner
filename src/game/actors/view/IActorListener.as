package game.actors.view 
{
	
	public interface IActorListener 
	{
		
		function actorDisappeared(id:int):void; 
		/** 
		 * call if want to unshow something immediately
		 * (if it was too far from the character, for example)
		**/
	}
	
}