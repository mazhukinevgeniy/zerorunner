package controller.observers 
{
	
	public interface ISoundObserver 
	{
		function setSoundMute(type:int, value:Boolean):void;
		function setSoundVolume(type:int, value:Number):void;
	}
	
}