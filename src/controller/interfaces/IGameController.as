package controller.interfaces 
{
	
	public interface IGameController 
	{
		function newGame():void;
		function quitGame():void;
		
		function gameFrame(frame:int):void;
	}
	
}