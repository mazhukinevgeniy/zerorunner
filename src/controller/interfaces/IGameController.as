package controller.interfaces 
{
	
	public interface IGameController 
	{
		function newGame():void;
		function quitGame():void;
		
		function gameFrame(frame:int):void;
		function mapFrame():void;
		
		function gameStopped(reason:int):void;
		
		function setVisibilityOfMenu(visible:Boolean):void;
		function setVisibilityOfMap(visible:Boolean):void;
	}
	
}