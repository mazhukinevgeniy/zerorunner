package binding 
{
	import model.interfaces.IScene;
	
	public interface IBinder 
	{
		function addBindable(object:*, type:Class):void;
		function requestBindingFor(object:IDependent):void;
		
		function get scene():IScene;
	}
	
}