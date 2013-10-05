package game.data 
{
	
	public interface IGame 
	{
		function get level():int;
		function get mapWidth():int;
		function get numberOfDroids():int;
		
		
		function getBeacon(level:int):int;
	}
	
}