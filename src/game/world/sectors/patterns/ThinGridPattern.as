package game.world.sectors.patterns 
{
	
	internal class ThinGridPattern implements IPattern
	{
		private var dX:int, dY:int;
		
		public function ThinGridPattern() 
		{
			this.dX = Math.random() * 2;
			this.dY = Math.random() * 2;
		}
		
		public function getNumber(x:int, y:int):int
		{
			return ((x + this.dX) % 2 == 0) || ((y + this.dY) % 2 == 0) ? 1 : 0;
		}
	}

}