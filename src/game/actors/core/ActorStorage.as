package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import game.actors.ActorsFeature;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.IScene;
	import game.ZeroRunner;
	
	public class ActorStorage implements IActorCache, ISearcher
	{
		private var actors:Vector.<ActorBase>;
		private var cache:Vector.<ActorBase>;
		
		private var flow:IUpdateDispatcher;
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.flow = flow;
			
			this.actors = new Vector.<ActorBase>(ActorsFeature.CAP, true);
			this.cache = new Vector.<ActorBase>(???, true); 
		}
		
		public function prerestore():void
		{
			this.pull.refill(this.actors, true);
		}
		
		public function findObjectByCell(cell:CellXY):Puppet
		{
			var hashcell:Vector.<Puppet> = this.hashmap[Metric.getHash(cell)];
			var hashLength:int = hashcell.length;
			
			for (var i:int = 0; i < hashLength; i++)
			{
				var item:Puppet = hashcell[i];
				if (cell.isEqualTo(item.cell))
				{
					return item;
				}
			}
			
			return null;
		}
		
		public function getCharacterCell():CellXY
		{
			return this.puppets[0].cell.getCopy();
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