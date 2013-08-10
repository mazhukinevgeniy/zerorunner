package game.searcher 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.scene.SceneFeature;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SearcherFeature implements ICacher, ISearcher
	{
		public static const cacheScene:String = "cacheScene";
		
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
			
			flow.dispatchUpdate(Time.addCacher, this);
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
			return null;
		}
		public function getCenter():ICoordinated
		{
			return null;
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
		
		private function cache0():void
		{
			//this.cacheCenter.setValue(this.center.x, this.center.y);
			//TODO: uncomment when this.center is stable
		}
		
		private function cache1():void
		{
			
		}
		
		private function cache2():void
		{
			
		}
		
		private function cache3():void
		{
			
		}
		
		private function cache4():void
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
	}

}