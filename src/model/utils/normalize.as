package model.utils
{
	
	public function normalize(value:int):int 
	{
		while (value < 0)
			value += Game.MAP_WIDTH;
		
		return value % Game.MAP_WIDTH;
	}
	
}