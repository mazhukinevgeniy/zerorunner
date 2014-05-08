package controller.interfaces 
{
	import controller.observers.ISoundObserver;
	
	public interface INotifier 
	{
		function addSoundObserver(observer:ISoundObserver):void;
		function addGameStatusObserver(observer:*):void;
		function addMapStatusObserver(observer:*):void;
		function addProjectileObserver(observer:*):void;
	}
	
}