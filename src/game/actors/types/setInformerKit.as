package game.actors.types 
{
	import game.actors.utils.InformerKit;
	
	public function setInformerKit(item:InformerKit):void
	{
		BroodmotherBase.juggler = item.juggler;
		
		BroodmotherBase.gameAtlas = item.assets.getTextureAtlas("gameAtlas");
		
		BroodmotherBase.world = item.world;
		BroodmotherBase.flow = item.flow;
	}
	
}