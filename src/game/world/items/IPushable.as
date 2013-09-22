package game.world.items 
{
	import game.core.metric.DCellXY;
	
	public interface IPushable 
	{
		function applyPush(change:DCellXY):void;
	}
	
}