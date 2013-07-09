package chaotic.actors.storage 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.storage.Puppet;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.xml.getActorsXML;
	
	public class ActorStorage implements ISearcher
	{
		private var puppets:Vector.<Puppet>;
		
		private var hashmap:Vector.<Vector.<Puppet>>;
		
		private var unusedIDs:Vector.<int>;
		
		private var active:int;
		
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener("addActor");
			flow.addUpdateListener("prerestore");
			flow.addUpdateListener("addInformerTo");
		}
		
		public function prerestore():void
		{
			var i:int;
			var configuration:XML = getActorsXML();
			
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
		
		public function addActor(item:Puppet):void
		{			
			this.puppets[item.id] = item;
			this.hashmap[Metric.getHash(item.cell)].push(item);
			
			this.active++;
		}
		public function moveObject(item:Puppet, change:DCellXY, inBetween:Function = null, ... args):void
		{
			this.removeFromHash(item);
			
			item.cell.applyChanges(change);
			
			if (inBetween != null)
				inBetween.apply(null, args);
			
			this.hashmap[Metric.getHash(item.cell)].push(item);
		}
		public function deleteObject(item:Puppet):void
		{
			if (item.active)
			{
				item.active = false;
				
				this.unusedIDs.push(item.id);
				this.active--;
				
				this.removeFromHash(item);
			}
		}
		
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
		
		private function removeFromHash(item:Puppet):void
		{
			var oldHash:Vector.<Puppet> = this.hashmap[Metric.getHash(item.cell)];
			oldHash.splice(oldHash.indexOf(item), 1);
		}
	}

}