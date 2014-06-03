package utils 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.IStatus;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	
	public class HeroChecker
	{
		private var lastCell:CellXY;
		
		private var status:IStatus;
		
		public function HeroChecker(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			
			this.lastCell = new CellXY( -1, -1);
			
			
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
		}
		
		public function checkIfHeroMoved():Boolean
		{
			var hero:ICoordinated = this.status.getLocationOfHero();
			var isMoved:Boolean = !this.lastCell.isEqualTo(hero);
			
			if (isMoved)
				this.lastCell.setValue(hero.x, hero.y);
			
			return isMoved;
		}
		
		private function newGame():void
		{
			this.lastCell.setValue( -1, -1);
		}
	}

}