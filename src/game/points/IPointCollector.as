package game.points 
{
	import game.core.metric.ICoordinated;
	import game.items.PuppetBase;
	
	public interface IPointCollector 
	{//TODO: it's multifunctional which is bad for a class or interface; REPAIR
		function addContraption(contraption:PuppetBase):void;
		function removeContraption(contraption:PuppetBase):void;
		function getContraption():PuppetBase;
		
		function getCharacter():ICoordinated;
		
		function addAlwaysActive(item:PuppetBase):void;
		function removeAlwaysActive(item:PuppetBase):void;
		function getAlwaysActives():Vector.<PuppetBase>;
	}
	
}