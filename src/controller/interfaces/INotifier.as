package controller.interfaces 
{
	import controller.observers.IGameStatusObserver;
	import controller.observers.ISoundObserver;
	
	public interface INotifier 
	{
		function addSoundObserver(observer:ISoundObserver):void;
		function addGameStatusObserver(observer:IGameStatusObserver):void;
	}
	
}