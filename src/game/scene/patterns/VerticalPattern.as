package game.scene.patterns 
{
	
	internal class VerticalPattern extends MiddlePattern 
	{
		private var period:int;
		private var width:int;
		
		public function VerticalPattern(item:Pattern) 
		{
			super(item);
			
			this.period = 5 + Math.random() * 10;
			this.width = this.period / (Math.random() > 0.5 ? 2 : 4);
		}
		
		override protected function getLocalNumber(x:int, y:int):int
		{
			return Math.abs(y % this.period) < this.width ? 1 : 0;
		}
	}

}