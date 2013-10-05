package game.data 
{
	
	public interface IGame 
	{
		function get mapWidth():int;
		
		function get level():int;
		
		function getBeacon(level:int):int;
	}
	
}