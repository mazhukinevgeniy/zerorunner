package model 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.interfaces.IFuel;
	import model.interfaces.IStatus;
	
	public class FuelTracker implements IFuel, INewGameHandler, IGameFrameHandler
	{
		private const MAX_CAPACITY:int = 80;
		
		private const BASE_REGENERATION:int = 1;
		private const BASE_WASTE:int = 4;
		
		private var amountOfFuel:int;
		
		private var status:IStatus;
		
		public function FuelTracker(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.status = binder.gameStatus;
		}
		
		public function newGame():void
		{
			this.amountOfFuel = this.MAX_CAPACITY;
		}
		
		public function gameFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				if (false)//TODO: create any other resource
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