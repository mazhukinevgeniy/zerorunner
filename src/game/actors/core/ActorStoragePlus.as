package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IGiveInformers;
	import game.achievements.statistics.IActorStatistic;
	import game.actors.core.ActorBase;
	import game.actors.core.ActorStorage;
	import game.actors.core.pull.ActorPull;
	import game.actors.view.ActiveCanvas;
	import game.input.IKnowInput;
	import game.scene.IScene;
	import game.state.IGameState;
	import game.ZeroRunner;
	
	use namespace update;
	
	public class ActorStoragePlus extends ActorStorage
	{
		private var pool:ActorPull;
		
		private var flow:IUpdateDispatcher;
		
		public function ActorStoragePlus(view:ActiveCanvas, flow:IUpdateDispatcher) 
		{
			this.view = view;
			this.flow = flow;
			
			super(flow);
			
			
			this.flow.workWithUpdateListener(this);
			//this.flow.addUpdateListener(ZeroRunner.tick); //TODO: allow actors acting
			this.flow.addUpdateListener(ZeroRunner.getInformerFrom);
		}
		
		final override update function aftertick():void
		{
			super.update::aftertick();
			
			this.refill(this.actors);
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			this.command.refill(this.actors, true);
			
			this.initializeCache();
		}
		
		/**
		 * @param force If true, forces recreation of active actors as well
		**/
		public function refill(vector:Vector.<ActorBase>, force:Boolean = false):void
		{
			var length:int = vector.length;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = vector[i];
				
				if (actor)
				{
					if (!actor.active || force)
					{
						this.pool.stash(actor);
						
						vector[i] = this.pool.getActor(i);
						
						actor = vector[i];
						
						this.listener.actorSpawned(actor.getID(), actor.giveCell(), actor.getClassCode());
					}
				}
				else
				{
					vector[i] = this.pool.getActor(i);
					
					actor = vector[i];
					
					this.listener.actorSpawned(actor.getID(), actor.giveCell(), actor.getClassCode());
				}
			}
		}
		
		
		
		update function tick():void
		{
			this.command.act(this.actors);
		}
		
		public function act(vector:Vector.<ActorBase>):void
		{
			var length:int = vector.length;
			
			for (var i:int = 0; i < length; i++)
				vector[i].act();
		}
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			ActorBase.iFlow = this.flow;
			ActorBase.iSearcher = this;
			ActorBase.iScene = table.getInformer(IScene);
			ActorBase.iStat = table.getInformer(IActorStatistic);
			ActorBase.iListener = this.listener;
			ActorBase.iInput = table.getInformer(IKnowInput);
			
			this.pool = new ActorPull(table.getInformer(IGameState));
		}
	}

}