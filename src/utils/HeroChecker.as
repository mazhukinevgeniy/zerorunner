package utils 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import model.interfaces.IStatus;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	
	public class HeroChecker implements INewGameHandler
	{
		private var lastCell:CellXY;
		
		private var status:IStatus;
		
		public function HeroChecker(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			
			this.lastCell = new CellXY( -1, -1);
			
			
			binder.notifier.addObserver(this);
		}
		
		public function checkIfHeroMoved():Boolean
		{
			var hero:ICoordinated = this.status.getLocationOfHero();
			var isMoved:Boolean = !this.lastCell.isEqualTo(hero);
			
			if (isMoved)
				this.lastCell.setValue(hero.x, hero.y);
			
			return isMoved;
		}
		
		public function newGame():void
		{
			this.lastCell.setValue( -1, -1);
		}
	}

}