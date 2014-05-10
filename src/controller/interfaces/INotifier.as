package controller.interfaces 
{
	import controller.observers.ISoundObserver;
	
	public interface INotifier 
	{
		function addObserver(observer:Object):void;
	}
	
}