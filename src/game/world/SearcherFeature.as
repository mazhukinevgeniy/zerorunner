package game.world 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	import starling.utils.AssetManager;
	import utils.informers.IStoreInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SearcherFeature implements ICacher, ISearcher
	{
		public static const cacheScene:String = "cacheScene";
		public static const cacheActors:String = "cacheActors";
		
		private var flow:IUpdateDispatcher;
		
		private var center:ICoordinated;
		
		/**/
		internal var cacheCenter:CellXY;
		
		internal var sceneCacheWidth:int;
		internal var sceneCacheHeight:int;
		
		internal var sceneCache:Vector.<int>
		
		internal var actorCacheWidth:int;
		internal var actorCacheHeight:int;
		
		internal var actorCache:Vector.<ActorLogicBase>;
		/**/
		
		private var cacheStepsDone:int;
		
		public function SearcherFeature(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			new Renderer(flow, this, assets);
			
			this.cacheCenter = new CellXY(0, 0);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.addActor);
			flow.addUpdateListener(ActorsFeature.moveActor);
			flow.addUpdateListener(ActorsFeature.removeActor);
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			
			const NUMBER_OF_STEPS:int = 5;
			for (var i:int = 0; i < NUMBER_OF_STEPS; i++)
				flow.dispatchUpdate(Time.addCacher, this);
			
			this.flow = flow;
			
			this.sceneCacheWidth = Metric.CELLS_IN_VISIBLE_WIDTH + 6;
			this.sceneCacheHeight = Metric.CELLS_IN_VISIBLE_HEIGHT + 6;
			
			this.sceneCache = new Vector.<int>(this.sceneCacheWidth * this.sceneCacheHeight, true);
			
			this.actorCacheWidth = Metric.CELLS_IN_VISIBLE_WIDTH + 2;
			this.actorCacheHeight = Metric.CELLS_IN_VISIBLE_HEIGHT + 2;
			
			this.actorCache = new Vector.<ActorLogicBase>(this.actorCacheWidth * this.actorCacheHeight, true);
		}
		
		update function restore():void
		{
			this.cacheStepsDone = 0;
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		/**
		 * Data access methods
		 */
		
		public function findObjectByCell(x:int, y:int):ActorLogicBase
		{
			if ((!(x < this.cacheCenter.x - this.actorCacheWidth / 2)) && (x < this.cacheCenter.x + this.actorCacheWidth / 2)
				&&
			    (!(y < this.cacheCenter.y - this.actorCacheHeight / 2)) && (y < this.cacheCenter.y + this.actorCacheHeight / 2))
			{
				x -= this.cacheCenter.x - this.actorCacheWidth / 2;
				y -= this.cacheCenter.y - this.actorCacheHeight / 2;
				
				return this.actorCache[x + y * this.actorCacheWidth];
			}
			else return null;
		}
		public function getCenter():ICoordinated
		{
			return this.center;
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			if ((!(x < this.cacheCenter.x - this.sceneCacheWidth / 2)) && (x < this.cacheCenter.x + this.sceneCacheWidth / 2)
				&&
			    (!(y < this.cacheCenter.y - this.sceneCacheHeight / 2)) && (y < this.cacheCenter.y + this.sceneCacheHeight / 2))
			{
				x -= this.cacheCenter.x - this.sceneCacheWidth / 2;
				y -= this.cacheCenter.y - this.sceneCacheHeight / 2;
				
				return this.sceneCache[x + y * this.sceneCacheWidth];
			}
			else return SceneFeature.FALL;
		}
		
		/**
		 * Caching
		 */
		
		public function cache():void
		{
			const NUMBER_OF_STEPS:int = 5;
			
			this["cache" + this.cacheStepsDone]();
			
			this.cacheStepsDone = (this.cacheStepsDone + 1) % NUMBER_OF_STEPS;
		}
		
		private function cache0():void //0
		{
			this.cacheCenter.setValue(this.center.x, this.center.y);
			
			var actorCacheLength:int = this.actorCacheWidth * this.actorCacheHeight;
			for (var i:int = 0; i < actorCacheLength; i++)
			{
				this.actorCache[i] = null;
			}
		}
		
		private function cache1():void //1
		{
			this.flow.dispatchUpdate(SearcherFeature.cacheScene, this.sceneCache, this.cacheCenter, 
										this.sceneCacheWidth, this.sceneCacheHeight);
		}
		
		private function cache2():void //2
		{
			this.flow.dispatchUpdate(SearcherFeature.cacheActors, this.actorCache, this.cacheCenter, 
										this.actorCacheWidth, this.actorCacheHeight);
		}
		
		private function cache3():void //3 or 0
		{
			//TODO: remove if not used
		}
		
		private function cache4():void //4 or 1
		{
			
		}
		
		/**
		 * Actors tracking
		 */
		
		update function addActor(item:ActorLogicBase):void
		{
			this.putActorInCell(item.x, item.y, item);
		}
		
		update function moveActor(actor:ActorLogicBase, change:DCellXY, delay:int):void
		{
			this.putActorInCell(actor.x - change.x, actor.y - change.y);
			this.putActorInCell(actor.x, actor.y, actor);
		}
		
		update function removeActor(actor:ActorLogicBase):void
		{
			this.putActorInCell(actor.x, actor.y);
		}
		
		/**
		 * Utils
		 */
		
		private function putActorInCell(x:int, y:int, item:ActorLogicBase = null):void
		{
			if ((!(x < this.cacheCenter.x - this.actorCacheWidth / 2)) && (x < this.cacheCenter.x + this.actorCacheWidth / 2)
				&&
			    (!(y < this.cacheCenter.y - this.actorCacheHeight / 2)) && (y < this.cacheCenter.y + this.actorCacheHeight / 2))
			{
				x -= this.cacheCenter.x - this.actorCacheWidth / 2;
				y -= this.cacheCenter.y - this.actorCacheHeight / 2;
				
				this.actorCache[x + y * this.actorCacheWidth] = item;
			}
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
	}

}