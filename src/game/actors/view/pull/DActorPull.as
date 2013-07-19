package game.actors.view.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.view.DrawenActor;
	
	public class DActorPull 
	{
		private var types:Vector.<Class>;
		
		private var pull:Vector.<Vector.<DrawenActor>>;
		
		private const NUMBER_OF_CLASSES:int = 9;
		
		public function DActorPull()
		{
			var types:Vector.<Class> = new Vector.<Class>(this.NUMBER_OF_CLASSES, true);
			
			types[ActorsFeature.TURRET] = DrawenTurret;
			types[ActorsFeature.CHARACTER] = DrawenCharacter;
			types[ActorsFeature.DOG] = DrawenDog;
			types[ActorsFeature.ROCKET] = DrawenRocket;
			types[ActorsFeature.HUNTER] = DrawenHunter;
			types[ActorsFeature.MECHANIC] = DrawenMechanic;
			types[ActorsFeature.MINE] = DrawenMine;
			types[ActorsFeature.RESEARCH_DROID] = DrawenResearchDroid;
			types[ActorsFeature.ROBOT] = DrawenRobot;
			
			this.types = types;
			
			
			var length:int = this.types.length;
			this.pull = new Vector.<Vector.<DrawenActor>>(length, true);
			
			for (var i:int = 0; i < length; i++)
			{
				this.pull[i] = new Vector.<DrawenActor>();
			}
		}
		
		public function stash(actor:DrawenActor):void
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
		
		public function getDrawenActor(type:int):DrawenActor
		{
			var actor:DrawenActor;
			actor = this.pull[type].pop();
			
			if (!actor)
			{
				actor = new this.types[type]();
			}
			
			return actor;
		}
	}

}