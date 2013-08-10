package game.actors 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
	import game.actors.types.character.Character;
	import game.actors.types.setInformerKit;
	import game.actors.utils.InformerKit;
	import game.input.IKnowInput;
	import game.metric.ICoordinated;
	import game.searcher.ISearcher;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.utils.AssetManager;
	import utils.informers.IGiveInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		private var flow:IUpdateDispatcher;
		private var input:IKnowInput;
		
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
		}
		
		update function cacheActors(cache:Vector.<ActorLogicBase>, center:ICoordinated, width:int, height:int):void
		{			
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				var actors:Vector.<ActorLogicBase> = this.broods[i].getActors();
				var alength:int = actors.length;
				
				for (var j:int = 0; j < alength; j++)
				{
					var actor:ActorLogicBase = actors[j];
					//TODO: make sure alength is always equal to actorCap
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
						actor.applyDestruction();
					}
				}
			}
			
		}
		
		
		
		update function aftertick():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function prerestore():void
		{
			this.broods = new Vector.<BroodmotherBase>();
			
			this.broods.push(new Character(this.input));
			
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
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			var kit:InformerKit = new InformerKit();
			
			kit.assets = table.getInformer(AssetManager);
			kit.juggler = table.getInformer(Juggler);
			
			kit.flow = this.flow;
			kit.world = table.getInformer(ISearcher);
			
			setInformerKit(kit);
			
			this.input = table.getInformer(IKnowInput);
		}
	}

}