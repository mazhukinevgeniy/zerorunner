package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	
	internal class Guardian extends ActorBase
	{
		private static const HP:int = 10;
		private static const MOVE_SPEED:int = 4;
		private static const ACTION_SPEED:int = 1000;
		
		private var isFixed:Boolean = false;
		
		public function Guardian() 
		{
			super(Guardian.HP, Guardian.MOVE_SPEED, Guardian.ACTION_SPEED);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		override protected function onCanMove():void
		{
			if (!this.isFixed)
			{
				var fall:int = SceneFeature.FALL;
				
				if ((this.scene.getSceneCell(new CellXY(x - 1, y)) != fall || this.scene.getSceneCell(new CellXY(x + 1, y)) != fall)
					&&
					(this.scene.getSceneCell(new CellXY(x , y - 1)) != fall || this.scene.getSceneCell(new CellXY(x, y + 1)) != fall)
				   )
				{
					var move:DCellXY = Metric.getRandomDCell();
					
					if (this.scene.getSceneCell(this.getCell().applyChanges(move)) != fall)
					{
						this.tryMove(move);
					}
				}
				else this.isFixed = true;
			}
		}
	}

}