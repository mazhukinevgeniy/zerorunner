package game.actors.core 
{
	
	internal interface IActorCache 
	{
		function putInCell(x:int, y:int, item:ActorBase = null):void;
	}
	
}