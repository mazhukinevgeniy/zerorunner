package game 
{
	
	public interface IGame 
	{
		function get level():int;
		function get mapWidth():int;
		
		function get numberOfDroids():int;
		function get numberOfJunks():int;
		
		
		function getBeacon(level:int):int;
	}
	
}