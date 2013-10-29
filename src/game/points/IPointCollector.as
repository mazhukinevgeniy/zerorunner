package game.points 
{
	import game.core.metric.ICoordinated;
	import game.items.base.ItemBase;
	
	public interface IPointCollector 
	{
		//TODO: check if we can name it better then "tower"
		function addTower(tower:ItemBase):void;
		function removeTower(tower:ItemBase):void;
		function getTower():ItemBase;
		
		function getCharacter():ICoordinated;
		
		function addAlwaysActive(item:ItemBase):void;
		function removeAlwaysActive(item:ItemBase):void;
		function getAlwaysActives():Vector.<ItemBase>;
	}
	
}