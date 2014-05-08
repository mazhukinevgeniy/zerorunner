package controller.interfaces 
{
	
	public interface IInputController 
	{
		function processInput(keyUp:Boolean, keyCode:uint):void;
		
		function processActivation():void;
		function processDeactivation():void;
	}
	
}