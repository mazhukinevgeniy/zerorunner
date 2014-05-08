package controller.observers.game 
{
	import model.metric.DCellXY;
	
	public interface IInputObserver 
	{
		function newInputPiece(isOn:Boolean, change:DCellXY):void;
	}
	
}