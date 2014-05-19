package utils 
{
	import model.metric.ICoordinated;
	
	public function distance(p1:ICoordinated, p2:ICoordinated):int
	{
		var x1:int = p1.x, x2:int = p2.x;
		var y1:int = p1.y, y2:int = p2.y;
		
		var xd1:int = Math.abs(x1 - x2);
		var xd2:int = Game.MAP_WIDTH - xd1;
		
		var yd1:int = Math.abs(y1 - y2);
		var yd2:int = Game.MAP_WIDTH - yd1;
		
		return Math.max(Math.min(xd1, xd2), Math.min(yd1, yd2));
	}
	
}