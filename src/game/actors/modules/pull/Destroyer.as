package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	
	internal class Destroyer extends ActorBase
	{
		private static const HP:int = 1;
		private static const MOVE_SPEED:int = 1;
		private static const ACTION_SPEED:int = 1000;
		
		
		private var forward:DCellXY = new DCellXY(1, 0);
		//private var jump:DCellXY = new DCellXY(2, 0); //TODO : also should think about other directions... or not?
		//TODO: not really effective, reimplement
		
		public function Destroyer() 
		{
			super(Destroyer.HP, Destroyer.MOVE_SPEED, Destroyer.ACTION_SPEED);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), 3);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		override protected function onCanMove():void
		{
			/*if (this.scene.getSceneCell(new CellXY(this.x + 1, this.y)) != SceneFeature.FALL)
				this.callMove(item, this.forward);
			else
				this.jumpActor(item, this.jump);*/
		}
	}

}