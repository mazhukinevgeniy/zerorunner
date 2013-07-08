package chaotic.choosenArea 
{
	import chaotic.metric.CellXY;
	
	internal class Sector implements ISector
	{
		private var _topLeftCell:CellXY;
		
		private var code:Vector.<int>;
		
		public function Sector(cell:CellXY, newCode:Vector.<int>) 
		{
			this._topLeftCell = cell;
			
			this.code = newCode;
		}
		
		public function get topLeftCell():CellXY { return this._topLeftCell; }
		public function getCode():Vector.<int> { return this.code; }
	}

}