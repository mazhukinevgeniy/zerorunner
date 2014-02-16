package game.points 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.items.Items;
	import game.items.PuppetBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class PointsOfInterest implements IPointCollector
	{
		private var contraptions:Vector.<PuppetBase>;
		private var actives:Vector.<PuppetBase>;
		
		private var character:ICoordinated;
		
		public function PointsOfInterest(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.puppetDies);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function restore(config:GameConfig):void
		{
			this.contraptions = new Vector.<PuppetBase>();
			this.actives = new Vector.<PuppetBase>();
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.character = center;
		}
		
		update function puppetDies(puppet:PuppetBase):void
		{
			var pos:int = this.contraptions.indexOf(puppet);
			
			if (pos != -1)
				this.contraptions.splice(pos, 1);
			else
			{
				pos = this.actives.indexOf(puppet);
				
				if (pos != -1)
					this.actives.splice(pos, 1);
			}
		}
		
		update function quitGame():void
		{
			this.contraptions = null;
			this.actives = null;
			this.character = null;
		}
		
		
		
		public function addContraption(contraption:PuppetBase):void 
		{ 
			if (this.contraptions.indexOf(contraption) == -1)
				this.contraptions.push(contraption);
		}
		
		public function getContraption():PuppetBase 
		{ 
			return this.contraptions[int(Math.random() * this.contraptions.length)];
		}
		
		public function removeContraption(contraption:PuppetBase):void 
		{
			var pos:int = this.contraptions.indexOf(contraption);
			if (pos != -1)
				this.contraptions.splice(pos, 1); 
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