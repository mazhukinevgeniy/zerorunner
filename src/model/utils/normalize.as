package model.utils
{
	
	public function normalize(value:int):int 
	{
		while (value < 0)
			value += Game.MAP_WIDTH;
		
		return value % Game.MAP_WIDTH;
	}
	//TODO: it's not model only, must relocate
}