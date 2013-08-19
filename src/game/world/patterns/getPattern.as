package game.world.patterns 
{
	
	
	public function getPattern():IPattern
	{
		if (Math.random() < 25 / 100)
				return new HorizontalPattern();
			else if (Math.random() < 25 / 75)
				return new VerticalPattern();
			else if (Math.random() < 25 / 50)
				return new ThinGridPattern();
			else
				return new CirclePattern();
	}
	
}