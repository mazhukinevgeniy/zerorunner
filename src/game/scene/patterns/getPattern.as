package game.scene.patterns 
{
	
	
	public function getPattern():IPattern
	{
		if (Math.random() < 20 / 100)
				return new HorizontalPattern();
			else if (Math.random() < 20 / 80)
				return new VerticalPattern();
			else if (Math.random() < 20 / 60)
				return new ThinGridPattern();
			else  if (Math.random() < 20 / 40)
				return new FlatPattern();
			else
				return new CirclePattern();
	}
	
}