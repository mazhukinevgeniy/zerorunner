package game.points 
{
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	
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