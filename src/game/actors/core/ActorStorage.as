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
	
	public class ActorStorage implements ISearcher
	{
		private var puppets:Vector.<Puppet>;
		
		
		private var flow:IUpdateDispatcher;
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.actorMoved);
			flow.addUpdateListener(ActorsFeature.actorDestroyed);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.flow = flow;
		}
		
		public function actorMoved(item:Puppet, change:DCellXY, ticksToGo:int):void
		{
			this.removeFromHash(item);
			
			item.cell.applyChanges(change);
			
			this.hashmap[Metric.getHash(item.cell)].push(item);
		}
		
		public function actorDestroyed(item:Puppet):void
		{
			if (item.id == 0)
			{
				this.flow.dispatchUpdate(ZeroRunner.gameOver);
			}
			else
			{
				this.deleteObject(item);
			}
		}
		
		private function deleteObject(item:Puppet):void
		{
			if (item.active)
			{
				item.active = false;
				
				this.unusedIDs.push(item.id);
				this.active--;
				
				this.removeFromHash(item);
			}
		}
		
		public function prerestore():void
		{
			this.puppets = new Vector.<Puppet>();
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