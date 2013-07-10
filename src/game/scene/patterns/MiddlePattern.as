package game.scene.patterns 
{
	import chaotic.errors.AbstractClassError;
	
	internal class MiddlePattern extends Pattern
	{
		private var nextPattern:Pattern;
		
		public function MiddlePattern(newItem:Pattern) 
		{
			this.nextPattern = newItem;
		}
		
		final override public function getNumber(x:int, y:int):int
		{
			return this.getLocalNumber(x, y) + this.nextPattern.getNumber(x, y);
		}
		
		protected function getLocalNumber(x:int, y:int):int
		{
			throw new AbstractClassError();
		}
	}

}