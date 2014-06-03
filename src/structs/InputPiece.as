package structs 
{
	import model.metric.DCellXY;
	import model.metric.ProtectedDCellXY;
	
	public class InputPiece 
	{
		private var _isOn:Boolean;
		private var _change:ProtectedDCellXY;
		
		public function InputPiece(isOn:Boolean, change:ProtectedDCellXY) 
		{
			this._isOn = isOn;
			this._change = change;
		}
		
		public function get isOn():Boolean
		{
			return this._isOn;
		}
		
		public function get change():DCellXY
		{
			return this._change;
		}
	}

}