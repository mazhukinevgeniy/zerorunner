package game.points 
{
	import game.core.metric.ICoordinated;
	import game.items.PuppetBase;
	
	public interface IPointCollector 
	{
		//TODO: check if we can name it better then "tower"
		function addTower(tower:PuppetBase):void;
		function removeTower(tower:PuppetBase):void;
		function getTower():PuppetBase;
		
		function getCharacter():ICoordinated;
		
		function addAlwaysActive(item:PuppetBase):void;
		function removeAlwaysActive(item:PuppetBase):void;
		function getAlwaysActives():Vector.<PuppetBase>;
	}
	
}