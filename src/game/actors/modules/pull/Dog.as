package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	
	internal class Dog extends ActorBase
	{
		private static const HP:int = 1;
		private static const MOVE_SPEED:int = 1;
		private static const ACTION_SPEED:int = 1;
		
		private static const DAMAGE:int = 4;
		
		
		private var forward:DCellXY;
		
		public function Dog() 
		{
			super(Dog.HP, Dog.MOVE_SPEED, Dog.ACTION_SPEED);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), String(3));
			
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
			else if (this.scene.getSceneCell(this.x + 2 * this.forward.x, this.y + 2 * this.forward.y) != SceneFeature.FALL)
				this.jump(this.forward, 2);
			else this.forward = Metric.getRandomDCell();
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			this.damageActor(this.searcher.findObjectByCell(this.x + change.x, this.y + change.y), Dog.DAMAGE);
		}
	}

}