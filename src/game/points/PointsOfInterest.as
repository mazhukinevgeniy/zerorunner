package game.points 
{
	import game.core.metric.ICoordinated;
	import game.items.ItemBase;
	import game.items.Items;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class PointsOfInterest implements IPointCollector
	{
		private var towers:Vector.<ItemBase>;
		private var actives:Vector.<ItemBase>;
		
		private var character:ICoordinated;
		
		public function PointsOfInterest(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function prerestore(... args):void
		{
			this.towers = new Vector.<ItemBase>();
			this.actives = new Vector.<ItemBase>();
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.character = center;
		}
		
		update function quitGame():void
		{
			this.towers = null;
			this.actives = null;
			this.character = null;
		}
		
		
		
		public function addTower(tower:ItemBase):void 
		{ 
			if (this.towers.indexOf(tower) == -1)
				this.towers.push(tower);
		}
		
		public function getTower():ItemBase 
		{ 
			return this.towers[int(Math.random() * this.towers.length)];
		}
		
		public function removeTower(tower:ItemBase):void 
		{
			var pos:int = this.towers.indexOf(tower);
			if (pos != -1)
				this.towers.splice(pos, 1); 
		}
		
		
		public function getCharacter():ICoordinated
		{
			return this.character;
		}
		
		
		public function addAlwaysActive(item:ItemBase):void
		{
			if (this.actives.indexOf(item) == -1)
				this.actives.push(item);
		}
		
		public function removeAlwaysActive(item:ItemBase):void
		{
			var pos:int = this.actives.indexOf(item);
			if (pos != -1)
				this.actives.splice(pos, 1); 
		}
		
		public function getAlwaysActives():Vector.<ItemBase>
		{
			return this.actives;
		}
	}

}