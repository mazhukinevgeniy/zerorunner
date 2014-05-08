package model.interfaces 
{
	import model.metric.ICoordinated;
	import model.status.NumericalDxyHelper;
	
	public interface IStatus 
	{
		function isGameOn():Boolean;
		function isMapOn():Boolean;
		
		function isHeroFree():Boolean;
		function isHeroAirborne():Boolean;
		function getLocationOfHero():ICoordinated;
		function getDisplacementOfHero():NumericalDxyHelper;
		
	}
	
}