package chaotic.updates 
{
	import chaotic.input.InputPiece;
	
	public interface IInputCollector 
	{
		function newInputPiece(item:InputPiece):void;
	}
	
}