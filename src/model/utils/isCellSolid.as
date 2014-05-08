package model.utils 
{
	
	public function isCellSolid(type:int):Boolean
	{
		return type == Game.SCENE_GROUND;
	}
	
}