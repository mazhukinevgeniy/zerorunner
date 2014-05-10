package controller.observers 
{
	import model.metric.DCellXY;
	
	public interface IInputObserver 
	{
		function newInputPiece(isOn:Boolean, change:DCellXY):void;
		
		function actionRequested(action:int):void;
	}
	
}