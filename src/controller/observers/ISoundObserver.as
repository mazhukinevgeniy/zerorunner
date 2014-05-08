package controller.observers 
{
	
	public interface ISoundObserver 
	{
		function setSoundMute(value:Boolean):void;
		function setMusicMute(value:Boolean):void;
		
		function setSoundValue(value:Number):void;
		function setMusicValue(value:Number):void;
	}
	
}