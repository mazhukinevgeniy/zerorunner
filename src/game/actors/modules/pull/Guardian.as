package game.actors.modules.pull 
{
	
	internal class Guardian 
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
				var x:int = item.x;
				var y:int = item.y;
				
				var fall:int = SceneFeature.FALL;
				
				var left:int = this.scene.getSceneCell(new CellXY(x - 1, y)),
					right:int = this.scene.getSceneCell(new CellXY(x + 1, y)),
					up:int = this.scene.getSceneCell(new CellXY(x , y - 1)),
					down:int = this.scene.getSceneCell(new CellXY(x, y + 1));
				
				if ((left != fall || right != fall)
					&&
					(up != fall || down != fall)
				   )
				{
					var move:DCellXY = Metric.getRandomDCell();
					
					if (this.scene.getSceneCell(item.getCell().applyChanges(move)) != fall)
					{
						this.callMove(item, move);
					}
				}
				else this.isFixed = true;
			}
		}
	}

}