package game.actors 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IGiveInformers;
	import game.actors.ActorsFeature;
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
			this.flow.addUpdateListener(ZeroRunner.tick);
			this.flow.addUpdateListener(ZeroRunner.getInformerFrom);
		}
		
		final override update function aftertick():void
		{
			super.update::aftertick();
			
			this.refillActors();
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			var length:int = ActorsFeature.CAP;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = this.actors[i];
				
				if (actor && actor.isActive)
				{
					this.pool.stash(actor);
				}
				
				this.actors[i] = null;
			}
			
			this.refillActors();
		}
		
		private function refillActors():void
		{			
			var length:int = this.state.actualActorsCap;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = this.actors[i];
				
				if (actor)
				{
					if (!actor.isActive)
					{
						this.pool.stash(actor);
						
						this.createActor(i);
					}
				}
				else
				{
					this.createActor(i);
				}
			}
		}
		
		private function createActor(id:int):void
		{
			var actor:ActorBase;
			actor = this.pool.getActor(id);
			
			while (!this.canBeCached(actor))
			{
				this.pool.stash(actor);
				actor = this.pool.getActor(id);
			}
			
			this.actors[id] = actor;
			
			this.putInCell(actor.x, actor.y, actor);
			
			ActorBase.iFlow.dispatchUpdate(ActorsFeature.addActor, actor);
		}
		
		
		
		update function tick():void
		{
			var length:int = this.state.actualActorsCap;
			
			for (var i:int = 0; i < length; i++)
				this.actors[i].act();
		}
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			var informers:Object = new Object();
			
			informers[IUpdateDispatcher] = this.flow; //TODO: etc; pass on every actor initialization
			
			ActorBase.iFlow = this.flow;
			ActorBase.iSearcher = this;
			ActorBase.iScene = table.getInformer(IScene);
			ActorBase.iListener = this.view;
			ActorBase.iInput = table.getInformer(IKnowInput);
			
			this.pool = new ActorPull();
			this.state = table.getInformer(IGameState);
		}
		
		/*
		 * 
		 * 
		
		update function addActor(item:ActorPuppet):void
		{
			var image:DrawenActor = (this.objects[item.getID()] = this.pull.getDrawenActor(item.getClassCode()));
			
			image.standOn(item.giveCell());
			
			this.container.addChild(image);
		}
		
		update function moveActor(item:ActorPuppet, change:DCellXY, delay:int):void
		{
			var id:int = item.getID();
			
			var tween:PixelPerfectTween = new PixelPerfectTween(this.objects[id], delay * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(item.x * Metric.CELL_WIDTH, item.y * Metric.CELL_HEIGHT);
			
			DrawenActor.iJuggler.add(tween);
			
			this.objects[id].moveNormally(item.giveCell(), change, delay);
		}
		
		 * 
		 */
	}

}