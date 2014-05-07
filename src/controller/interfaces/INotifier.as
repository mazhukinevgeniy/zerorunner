package controller.interfaces 
{
	import controller.observers.ISoundObserver;
	
	public interface INotifier 
	{
		function addSoundObserver(observer:ISoundObserver):void;
	}
	
}