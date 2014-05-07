package binding 
{
	import controller.interfaces.IInputController;
	import controller.interfaces.INotifier;
	import controller.interfaces.ISoundController;
	import model.interfaces.IScene;
	import starling.utils.AssetManager;
	
	public interface IBinder 
	{
		function addBindable(object:*, type:Class):void;
		function requestBindingFor(object:IDependent):void;
		
		function get scene():IScene;
		function get notifier():INotifier;
		function get assetManager():AssetManager;
		function get inputController():IInputController;
		function get soundController():ISoundController;
	}
	
}