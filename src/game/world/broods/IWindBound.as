package game.world.broods 
{
	import game.utils.metric.DCellXY;
	
	public interface IWindBound 
	{
		function applyWind(change:DCellXY):void;
	}
	
}