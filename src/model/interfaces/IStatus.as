package model.interfaces 
{
	import game.metric.ICoordinated;
	
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