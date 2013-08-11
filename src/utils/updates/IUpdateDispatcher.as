package utils.updates 
{
	
	public interface IUpdateDispatcher 
	{
		function dispatchUpdate(updateName:String, ... args):void;
		
		function workWithUpdateListener(listener:Object):void;
		function addUpdateListener(method:String):void;
	}

}