package game.actors.core.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	internal class BattleDroid extends ActorBase
	{
		private static const HP:int = 10;
		private static const MOVE_SPEED:int = 2;
		private static const ACTION_SPEED:int = 400;
		
		
		private var forward:DCellXY;
		
		public function BattleDroid() 
		{
			super(BattleDroid.HP, BattleDroid.MOVE_SPEED, BattleDroid.ACTION_SPEED);
		}
		
		
		override protected function onSpawned():void
		{
			this.forward = Metric.getRandomDCell();
		}
		
		override public function getClassCode():int
		{
			return ActorsFeature.BATTLE_DROID;
		}
		
		override protected function onCanMove():void
		{
			if (Math.random() < 0.2)
				this.forward = Metric.getRandomDCell();
			else
				this.tryMove(this.forward);
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			this.forward = Metric.getRandomDCell();
		}
	}

}