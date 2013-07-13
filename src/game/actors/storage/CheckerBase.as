package game.actors.storage 
{
	import game.scene.SceneFeature;
	
	internal class CheckerBase 
	{
		
		public function CheckerBase() 
		{
			
		}
		
		/*
		final protected function isGrinded(item:ActorBase):void
		{
			if (ActorBase.grinder.isGrinded(item.cell))
			{
				this.destroyActor(item);
			}
			
		}*/ // TODO: move to the caching code
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.scene.getSceneCell(item.cell) == SceneFeature.FALL)
			{
				this.destroyActor(item);
			}
		}
		/*
		final protected function isOutOfBounds(item:ActorBase):void
		{
			...
		}*/ // TODO: reimplement in the cache
	}

}