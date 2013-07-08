package view 
{
	import controller.IController;
	
	public interface IView 
	{
		function toggleWindow(id:int):void;
		
		function showGame():void;
		function hideGame():void;
		
		function showPanel():void;
		function hidePanel():void;
		
		function setController(item:IController):void;
		
		function toggleSound():void;
	}
	
}