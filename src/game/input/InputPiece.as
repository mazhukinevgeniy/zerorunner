package game.input 
{
	import game.metric.DCellXY;
	
	public class InputPiece 
	{
		public var change:DCellXY;
		public var isKeyboard:Boolean;
		public var isOn:Boolean;
		
		public function InputPiece(isKeyboard:Boolean, isOn:Boolean, change:DCellXY) 
		{
			this.isKeyboard = isKeyboard;
			this.isOn = isOn;
			
			this.change = change;
		}
		
	}

}