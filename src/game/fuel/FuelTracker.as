package game.fuel 
{
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.PuppetBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class FuelTracker implements IFuel
	{
		private const MAX_CAPACITY:int = 80;
		
		private const BASE_REGENERATION:int = 1;
		private const BASE_WASTE:int = 4;
		
		
		private var amountOfFuel:int;
		
		private var character:PuppetBase;
		
		public function FuelTracker(elements:GameElements) 
		{
			if (Game.FRAME_TO_ACT + 1 == Game.FRAMES_PER_CYCLE)
				throw new Error("change constants please");
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.numberedFrame);
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.amountOfFuel = this.MAX_CAPACITY;
			
			this.character = center as PuppetBase;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT + 1)
			{
				var occ:int = this.character.occupation;
				
				if (occ == Game.OCCUPATION_FLOATING || occ == Game.OCCUPATION_FLYING)
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
		
		//TODO: each tick check what the character's occupation is etc
	}

}