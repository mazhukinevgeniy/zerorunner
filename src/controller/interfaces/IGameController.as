package controller.interfaces 
{
	import controller.observers.IGameFrameHandler;
	import controller.observers.IGameMapObserver;
	import controller.observers.IGameMenuObserver;
	import controller.observers.IGameObserver;
	import controller.observers.IGameStopHandler;
	import controller.observers.IMapFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	
	public interface IGameController extends IGameMenuObserver,
	                                         IGameMapObserver,
											 IGameObserver,
											 INewGameHandler,
											 IQuitGameHandler,
											 IGameFrameHandler,
											 IMapFrameHandler,
											 IGameStopHandler
	{
		
	}
	
}