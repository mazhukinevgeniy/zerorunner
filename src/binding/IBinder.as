package binding 
{
	import controller.interfaces.IInputController;
	import model.interfaces.ICollectibles;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IItemSnapshotter;
	import model.interfaces.IProjectiles;
	import model.interfaces.ISave;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import starling.events.EventDispatcher;
	import starling.utils.AssetManager;
	
	public interface IBinder 
	{
		function addBindable(object:*, type:Class):void;
		function requestBindingFor(object:IDependent):void;
		
		function get save():ISave;
		function get scene():IScene;
		function get input():IInput;
		function get gameStatus():IStatus;
		function get projectiles():IProjectiles;
		function get exploration():IExploration;
		function get assetManager():AssetManager;
		function get collectibles():ICollectibles;
		function get eventDispatcher():EventDispatcher;
		function get inputController():IInputController;
		function get itemSnapshotter():IItemSnapshotter;
	}
	
}