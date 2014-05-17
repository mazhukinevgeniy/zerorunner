package model.interfaces 
{
	
	public interface ISave 
	{
		function getSoundMute(type:int):Boolean;
		function getSoundVolume(type:int):Number;
		
		function getCollectibleFound(type:int):Boolean;
	}
	
}