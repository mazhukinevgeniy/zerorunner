package game.actors.storage 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IStoreInformers;
	import game.actors.ActorsFeature;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	
	public class ActorStorage implements ISearcher
	{
		private var puppets:Vector.<Puppet>;
		
		private var hashmap:Vector.<Vector.<Puppet>>;
		
		private var unusedIDs:Vector.<int>;
		
		private var active:int;
		
		
		private var flow:IUpdateDispatcher;
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.actorAdded);
			flow.addUpdateListener(ActorsFeature.actorMoved);
			flow.addUpdateListener(ActorsFeature.actorDestroyed);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			
			this.flow = flow;
		}
		
		public function actorAdded(item:Puppet):void
		{			
			this.puppets[item.id] = item;
			this.hashmap[Metric.getHash(item.cell)].push(item);
			
			this.active++;
		}
		
		public function actorMoved(item:Puppet, change:DCellXY):void
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
		
		private function removeFromHash(item:Puppet):void
		{
			var oldHash:Vector.<Puppet> = this.hashmap[Metric.getHash(item.cell)];
			oldHash.splice(oldHash.indexOf(item), 1);
		}
		
		public function prerestore():void
		{
			var i:int;
			var configuration:XML = ActorsFeature.CONFIG;
			
			this.puppets = new Vector.<Puppet>();
			
			var length:int = Metric.getMaximumHash();
			this.hashmap = new Vector.<Vector.<Puppet>>(length, true);
			
			for (i = 0; i < length; i++)
				this.hashmap[i] = new Vector.<Puppet>();
			
			this.unusedIDs = new Vector.<int>();
			
			for (i = 0; i < ActorsFeature.CAP; i++)
				this.unusedIDs[i] = ActorsFeature.CAP - i;
			
			this.active = 0;
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
		public function getObject(id:int):Puppet
		{
			return this.puppets[id];
		}
		public function getNumberOfObjects():int
		{
			return this.puppets.length;
		}
		public function getNumberOfActives():int
		{
			return this.active;
		}
		public function getUnusedID():int
		{
			return this.unusedIDs.pop();
		}
		
		public function addUnusedID(id:int):void
		{
			this.unusedIDs.push(id);
		}
		
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
	}

}