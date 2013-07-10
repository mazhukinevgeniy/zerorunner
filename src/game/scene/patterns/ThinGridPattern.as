package game.scene.patterns 
{
	
	internal class ThinGridPattern extends MiddlePattern
	{
		private var dX:int, dY:int;
		
		public function ThinGridPattern(item:Pattern) 
		{
			super(item);
			
			this.dX = Math.random() * 2;
			this.dY = Math.random() * 2;
		}
		
		override protected function getLocalNumber(x:int, y:int):int
		{
			return ((x + this.dX) % 2 == 0) || ((y + this.dY) % 2 == 0) ? 1 : 0;
		}
	}

}