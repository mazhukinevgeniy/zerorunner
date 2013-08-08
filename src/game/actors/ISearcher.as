package game.actors 
{
	import game.actors.types.ActorPuppet;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public interface ISearcher
	{
		function findObjectByCell(x:int, y:int):ActorPuppet;
		
		function getCharacterCell(storeIn:CellXY):void;
		function get character():ICoordinated;
	}
	
}