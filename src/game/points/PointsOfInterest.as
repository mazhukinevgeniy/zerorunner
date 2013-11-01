package game.points 
{
	import game.core.metric.ICoordinated;
	import game.items.Items;
	import game.items.PuppetBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class PointsOfInterest implements IPointCollector
	{
		private var towers:Vector.<PuppetBase>;
		private var actives:Vector.<PuppetBase>;
		
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
			this.towers = new Vector.<PuppetBase>();
			this.actives = new Vector.<PuppetBase>();
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
		
		
		
		public function addTower(tower:PuppetBase):void 
		{ 
			if (this.towers.indexOf(tower) == -1)
				this.towers.push(tower);
		}
		
		public function getTower():PuppetBase 
		{ 
			return this.towers[int(Math.random() * this.towers.length)];
		}
		
		public function removeTower(tower:PuppetBase):void 
		{
			var pos:int = this.towers.indexOf(tower);
			if (pos != -1)
				this.towers.splice(pos, 1); 
		}
		
		
		public function getCharacter():ICoordinated
		{
			return this.character;
		}
		
		
		public function addAlwaysActive(item:PuppetBase):void
		{
			if (this.actives.indexOf(item) == -1)
				this.actives.push(item);
		}
		
		public function removeAlwaysActive(item:PuppetBase):void
		{
			var pos:int = this.actives.indexOf(item);
			if (pos != -1)
				this.actives.splice(pos, 1); 
		}
		
		public function getAlwaysActives():Vector.<PuppetBase>
		{
			return this.actives;
		}
	}

}