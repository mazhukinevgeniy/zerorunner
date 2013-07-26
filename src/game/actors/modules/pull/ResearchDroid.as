package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	internal class ResearchDroid extends ActorBase
	{
		private static const HP:int = 10;
		private static const MOVE_SPEED:int = 2;
		private static const ACTION_SPEED:int = 400;
		
		
		private var forward:DCellXY;
		
		public function ResearchDroid() 
		{
			super(ResearchDroid.HP, ResearchDroid.MOVE_SPEED, ResearchDroid.ACTION_SPEED);
		}
		
		
		override protected function onSpawned():void
		{
			this.forward = Metric.getRandomDCell();
		}
		
		override public function getClassCode():int
		{
			return ActorsFeature.RESEARCH_DROID;
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