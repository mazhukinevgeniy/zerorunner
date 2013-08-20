package game.world.broods 
{
	import utils.errors.AbstractClassError;
	
	public class BroodmotherBase 
	{
		
		public function BroodmotherBase()
		{
			this.refillActors();
		}
		
		private function refillActors():void
		{
			var length:int = this.getActorsCap();
			var actor:ItemLogicBase;
			
			for (var i:int = 0; i < length; i++)
				actor = this.newActor();
		}
		
		protected function newActor():ItemLogicBase
		{
			throw new AbstractClassError();
		}
		
		protected function getActorsCap():int
		{
			throw new AbstractClassError();
		}
		
	}

}