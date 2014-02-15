package  
{
	
	public function normalize(value:int):int 
	{
		return (value + Game.MAP_WIDTH) % Game.MAP_WIDTH;
	}
	
}