package utils 
{
	import model.metric.DCellXY;
	
	public function getDirection(change:DCellXY):int
	{
		var dir:int;
		
		if (change.x < 0)
			dir = Game.DIRECTION_LEFT;
		else if (change.y > 0)
			dir = Game.DIRECTION_DOWN;
		else if (change.y < 0)
			dir = Game.DIRECTION_TOP;
		else 
			dir = Game.DIRECTION_RIGHT;
		
		return dir;
	}
	
}