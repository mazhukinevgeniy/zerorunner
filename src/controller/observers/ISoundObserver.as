package controller.observers 
{
	
	public interface ISoundObserver 
	{
		function setSoundMute(type:int, value:Boolean):void;
		function setSoundValue(type:int, value:Number):void;
	}
	
}