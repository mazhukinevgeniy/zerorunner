package game.actors.core 
{
	
	internal interface IActorCache 
	{
		function cleanCell(x:int, y:int);
		function putInCell(x:int, y:int, item:ActorBase);
	}
	
}