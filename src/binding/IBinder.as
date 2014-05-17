package binding 
{
	import controller.interfaces.IGameController;
	import controller.interfaces.IInputController;
	import controller.interfaces.INotifier;
	import controller.interfaces.IProjectileController;
	import controller.interfaces.IScreenController;
	import controller.interfaces.ISoundController;
	import model.interfaces.ICollectibles;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IProjectiles;
	import model.interfaces.IPuppets;
	import model.interfaces.ISave;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import starling.utils.AssetManager;
	
	public interface IBinder 
	{
		function addBindable(object:*, type:Class):void;
		function requestBindingFor(object:IDependent):void;
		
		function get save():ISave;
		function get scene():IScene;
		function get input():IInput;
		function get puppets():IPuppets;
		function get notifier():INotifier;
		function get gameStatus():IStatus;
		function get projectiles():IProjectiles;
		function get exploration():IExploration;
		function get assetManager():AssetManager;
		function get collectibles():ICollectibles;
		function get gameController():IGameController;
		function get inputController():IInputController;
		function get soundController():ISoundController;
		function get screenController():IScreenController;
		function get projectileController():IProjectileController;
	}
	
}