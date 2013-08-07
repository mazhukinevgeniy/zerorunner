package game.actors.types 
{
	
	public class BroodmotherBase 
	{
		public static const EXTINCTING:int = 0;
		public static const APPEARING:int = 1;
		
		private var mode:int;
		
		private var types:Vector.<Class> = new <Class>[Character, ResearchDroid, BattleDroid, Dog, Mechanic];
		
		private var pull:Vector.<Vector.<ActorBase>>;
		
		public function ActorPull()
		{
			var length:int = this.types.length;
			this.pull = new Vector.<Vector.<ActorBase>>(length, true);
			
			for (var i:int = 0; i < length; i++)
			{
				this.pull[i] = new Vector.<ActorBase>();
			}
		}
		
		public function stash(actor:ActorBase):void
		{
			var length:int = this.types.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (actor is this.types[i])
				{
					this.pull[i].push(actor);
					return;
				}
			}
		}
		
		public function getActor(id:int):ActorBase
		{
			var actor:ActorBase;
			
			var type:int = int(Boolean(id)) * (1 + int(Math.random() * 4));
			actor = this.pull[type].pop();
			
			if (!actor)
			{
				actor = new this.types[type]();
			}
			
			actor.reset(id);
			
			return actor;
		}
		
	}

}