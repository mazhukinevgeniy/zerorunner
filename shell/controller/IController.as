package controller 
{
	import starling.events.KeyboardEvent;
	import view.events.MainMenuEvent;
	import view.events.NavigationEvent;
	import view.events.PanelEvent;
	
	public interface IController 
	{
		function keyUp(event:KeyboardEvent):void;
		function keyDown(event:KeyboardEvent):void;
		
		function toggleSound():void;
		
		function handleNavigationEvent(event:NavigationEvent):void;
		function handleMainMenuEvent(event:MainMenuEvent):void;
		function handlePanelEvent(event:PanelEvent):void;
		
		function focusIn():void;
		function focusOut():void;
		
		function viewPrepared():void;
	}
	
}