package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	
	internal class Destroyer extends ActorBase
	{
		private static const HP:int = 1;
		private static const MOVE_SPEED:int = 1;
		private static const ACTION_SPEED:int = 1;
		
		private static const DAMAGE:int = 4;
		
		
		private var forward:DCellXY;
		
		public function Destroyer() 
		{
			super(Destroyer.HP, Destroyer.MOVE_SPEED, Destroyer.ACTION_SPEED);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), 3);
			
			this.forward = Metric.getRandomDCell();
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		override protected function onCanMove():void
		{
			if (this.scene.getSceneCell(this.x + this.forward.x, this.y + this.forward.y) != SceneFeature.FALL)
				this.tryMove(this.forward);
			else
				this.jump(this.forward, 2);
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			this.damageActor(this.searcher.findObjectByCell(this.x + change.x, this.y + change.y), Destroyer.DAMAGE);
		}
	}

}