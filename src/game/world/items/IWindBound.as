package game.world.items 
{
	import game.core.metric.DCellXY;
	
	public interface IWindBound 
	{
		function applyWind(change:DCellXY):void;
	}
	
}