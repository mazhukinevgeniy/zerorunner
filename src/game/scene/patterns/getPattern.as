package game.scene.patterns 
{
	
	
	public function getPattern():IPattern
	{
		if (Math.random() < 25 / 100) //25% to go
				return new HorizontalPattern();
			else if (Math.random() < 25 / 75) //25% to go
				return new VerticalPattern();
			else if (Math.random() < 25 / 50) //25% to go
				return new ThinGridPattern();
			else 
				return new CirclePattern();
	}
	
}