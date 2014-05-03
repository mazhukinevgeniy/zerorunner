package game.fuel 
{
	import data.IStatus;
	import game.GameElements;
	import game.interfaces.IRestorable;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class FuelTracker implements IFuel, IRestorable
	{
		private const MAX_CAPACITY:int = 80;
		
		private const BASE_REGENERATION:int = 1;
		private const BASE_WASTE:int = 4;
		
		private var amountOfFuel:int;
		
		private var status:IStatus;
		
		public function FuelTracker(elements:GameElements) 
		{
			elements.restorer.addSubscriber(this);
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.status = elements.status;
		}
		
		public function restore():void
		{
			this.amountOfFuel = this.MAX_CAPACITY;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				if (this.status.isHeroAirborne())
				{
					this.amountOfFuel -= this.BASE_WASTE;
					
					if (this.amountOfFuel < 0)
						this.amountOfFuel = 0;
				}
				else if (this.amountOfFuel < this.MAX_CAPACITY)
				{
					this.amountOfFuel += this.BASE_REGENERATION;
					
					if (this.amountOfFuel >= this.MAX_CAPACITY)
						this.amountOfFuel = this.MAX_CAPACITY;
				}
				
			}
		}
		
		public function getAmountOfFuel():int { return this.amountOfFuel; }
		public function getFuelCap():int {	return this.MAX_CAPACITY; }
		
	}

}