package game.scene.patterns 
{
	
	public class ScenePattern extends MiddlePattern
	{
		
		public function ScenePattern() 
		{
			var lastPattern:Pattern = new Pattern();
			var anotherPattern:MiddlePattern;
			
			var length:int = 1;
			
			for (var i:int = 0; i < length; i++)
			{
				anotherPattern = this.getPattern(lastPattern);
				lastPattern = anotherPattern;
			}
			
			super(lastPattern);
		}
		
		private function getPattern(next:Pattern):MiddlePattern
		{
			if (Math.random() < 25 / 100) //25% to go
				return new HorizontalPattern(next);
			else if (Math.random() < 25 / 75) //25% to go
				return new VerticalPattern(next);
			else if (Math.random() < 25 / 50) //25% to go
				return new ThinGridPattern(next);
			else 
				return new CirclePattern(next);
		}
		
		override protected function getLocalNumber(x:int, y:int):int
		{
			return 0;
		}
	}

}