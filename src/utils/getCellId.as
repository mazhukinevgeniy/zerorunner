package utils
{
	
	public function getCellId(x:int, y:int):int 
	{
		x = normalize(x);
		y = normalize(y);
		
		return x + y * Game.MAP_WIDTH;
	}
}