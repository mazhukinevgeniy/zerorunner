package game.world.cache 
{
	import game.utils.GameFoundations;
	import game.utils.metric.ICoordinated;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.BroodsFeature;
	import game.world.broods.IGiveBroods;
	import game.world.broods.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(foundations:GameFoundations, broods:IGiveBroods) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.broods = new Vector.<BroodmotherBase>();
			
			this.broods.push(broods.getBrood(BroodsFeature.CHARACTER));
			this.broods.push(broods.getBrood(BroodsFeature.CHECKPOINT));
			this.broods.push(broods.getBrood(BroodsFeature.FOG));
			this.broods.push(broods.getBrood(BroodsFeature.SKY_CLEARER));
			this.broods.push(broods.getBrood(BroodsFeature.TECHNIC));
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.tick);
			flow.addUpdateListener(Update.aftertick);
		}
		
		update function prerestore():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function tick():void
		{
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				this.broods[i].act();
			}
		}
		
		update function aftertick():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
	}

}