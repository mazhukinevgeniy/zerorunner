package game.scene.patterns 
{
	
	internal class HorizontalPattern extends MiddlePattern 
	{
		private var period:int;
		private var height:int;
		
		public function HorizontalPattern(item:Pattern) 
		{
			super(item);
			
			this.period = 5 + Math.random() * 10;
			this.height = this.period / (Math.random() > 0.5 ? 2 : 4);
		}
		
		override protected function getLocalNumber(x:int, y:int):int
		{
			return Math.abs(x % this.period) < this.height ? 1 : 0;
		}
	}

}