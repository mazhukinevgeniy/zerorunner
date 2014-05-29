package model.interfaces 
{
	import model.items.ItemSnapshot;
	import model.metric.ICoordinated;
	
	public interface IStatus 
	{
		function isGameOn():Boolean;
		function isGameStopped():Boolean;
		function isMapOn():Boolean;
		function isMenuOn():Boolean;
		
		function getLocationOfHero():ICoordinated;
		function getSnapshotOfHero():ItemSnapshot;
	}
	
}