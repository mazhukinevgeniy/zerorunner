package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import game.actors.ActorsFeature;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.scene.IScene;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	
	public class ActorStorage implements ICacher, IActorCache, ISearcher
	{
		private var actors:Vector.<ActorBase>;
		
		
		private var cacheV:Vector.<ActorBase>;
		
		private var cacheWidth:int;
		private var cacheHeight:int;
		private var cacheLength:int;
		
		private var cacheIsCleared:Boolean;
		
		private var flow:IUpdateDispatcher;
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.flow = flow;
			
			this.cacheWidth = Metric.xDistanceActorsAllowed * 2;
			this.cacheHeight = Metric.yDistanceActorsAllowed * 2;
			this.cacheLength = this.cacheWidth * this.cacheHeight;
			
			this.actors = new Vector.<ActorBase>(ActorsFeature.CAP, true);
			this.cache = new Vector.<ActorBase>(this.cacheLength, true);
			
			flow.dispatchUpdate(Time.addCacher, this);
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		public function prerestore():void
		{
			this.pull.refill(this.actors, true);
			
			this.cacheIsCleared = false;
		}
		
		public function cache():void
		{
			var i:int;
			
			if (this.cacheIsCleared)
			{
				for (i = 0; i < ActorsFeature.CAP; i++)
				{
					// TODO: fill the cache; perform outOfBounds check
				}
			}
			else
			{
				for (i = 0; i < this.cacheLength; i++)
					this.cacheV[i] = null;
			}
			
			this.cacheIsCleared = !this.cacheIsCleared;
		}
		
		public function findObjectByCell(cell:CellXY):ActorBase
		{
			return this.cacheV[cell.x + cell.y * this.cacheWidth];
		}
		
		public function getCharacterCell(cell:CellXY):void
		{
			var ccell:CellXY = this.actors[0].cell;
			cell.x = ccell.x;
			cell.y = ccell.y;
		}
		
		
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			ActorBase.iFlow = this.flow;
			ActorBase.iSearcher = this;
			ActorBase.iGrinder = table.getInformer(IGrinder);
			ActorBase.iScene = table.getInformer(IScene);
			ActorBase.iListener = this.listener;
		}
	}

}