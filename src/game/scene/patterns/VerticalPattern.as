package game.scene.patterns 
{
	
	internal class VerticalPattern implements IPattern 
	{
		private var period:int;
		private var width:int;
		
		public function VerticalPattern() 
		{
			this.period = 5 + Math.random() * 10;
			this.width = this.period / (Math.random() > 0.5 ? 2 : 4);
		}
		
		public function getNumber(x:int, y:int):int
		{
			return Math.abs(y % this.period) < this.width ? 1 : 0;
		}
	}

}