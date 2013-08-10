package game.actors 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
	import game.metric.ICoordinated;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		private var flow:IUpdateDispatcher;
		
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
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
			
			//TODO: add some broods
			
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
	}

}