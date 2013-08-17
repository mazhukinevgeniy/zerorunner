package game.items 
{
	import game.input.IKnowInput;
	import game.items.character.Character;
	import game.items.checkpoint.Checkpoint;
	import game.items.fog.Fog;
	import game.items.skyClearer.IGiveTowers;
	import game.items.skyClearer.SkyClearer;
	import game.items.technic.Technic;
	import game.metric.ICoordinated;
	import game.utils.GameFoundations;
	import game.world.ISearcher;
	import game.world.SearcherFeature;
	import game.ZeroRunner;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		private var flow:IUpdateDispatcher;
		private var input:IKnowInput;
		
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(foundations:GameFoundations, world:ISearcher) 
		{
			BroodmotherBase.juggler = foundations.juggler;
			BroodmotherBase.gameAtlas = foundations.atlas;
			BroodmotherBase.flow = this.flow = foundations.flow;
			BroodmotherBase.world = world;
			
			this.input = foundations.input;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ZeroRunner.prerestore);
			this.flow.addUpdateListener(ZeroRunner.tick);
			this.flow.addUpdateListener(ZeroRunner.aftertick);
			this.flow.addUpdateListener(SearcherFeature.cacheActors);
			
			new WindFeature(this.flow);
		}
		
		update function cacheActors(cache:Vector.<ItemLogicBase>, center:ICoordinated, width:int, height:int):void
		{			
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				var actors:Vector.<ItemLogicBase> = this.broods[i].getActors();
				var alength:int = actors.length;
				
				for (var j:int = 0; j < alength; j++)
				{
					var actor:ItemLogicBase = actors[j];
					
					if (actor.active)
					{
						var x:int = actor.x;
						var y:int = actor.y;
						
						if ((!(x < center.x - width / 2)) && (x < center.x + width / 2)
							&&
							(!(y < center.y - height / 2)) && (y < center.y + height / 2))
						{
							x -= center.x - width / 2;
							y -= center.y - height / 2;
							
							cache[x + y * width] = actor;
						}
						else
						{
							this.broods[i].actorOutOfCache(actor);
						}
					}
				}
			}
			
		}
		
		
		update function prerestore():void
		{
			this.broods = new Vector.<BroodmotherBase>();
			
			this.broods.push(new Character(this.input));
			this.broods.push(new Checkpoint());
			this.broods.push(new Fog());
			this.broods.push(new SkyClearer());
			this.broods.push(new Technic(this.broods[3] as IGiveTowers));
			
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function tick():void
		{
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				this.broods[i].act();
			}
		}
		
		update function aftertick():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
	}

}