package game.actors.modules.pull 
{
	
	internal class Guardian 
	{
		private static const configuration = new XML
		(
			<actor>
				<baseHP>10</baseHP>
				<speed>4</speed>
				<configuration>
					<check>NormalLandscapeCheck</check>
					<check>OutOfBoundsCheck</check>
					<check>IsGrindedCheck</check>
					<action>SearchCorridor</action>
				</configuration>
				<getCell>getRandomCell</getCell>
				<chance>0.3</chance>
			</actor>
		);
		
		private var isFixed:Boolean = false;
		
		public function Guardian() 
		{
			
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