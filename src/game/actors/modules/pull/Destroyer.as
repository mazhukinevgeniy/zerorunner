package game.actors.modules.pull 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	
	internal class Destroyer 
	{
		private static const configuration = new XML
		(
			<actor>
				<baseHP>1</baseHP>
				<speed>1</speed>
				<configuration>
					<check>NormalLandscapeCheck</check>
					<action>RunForward</action>
				</configuration>
				<getCell>getGrindedCell</getCell>
				<chance>0.4</chance>
			</actor>
		);
		
		
		private var forward:DCellXY = new DCellXY(1, 0);
		private var jump:DCellXY = new DCellXY(2, 0);
		//TODO: not really effective, reimplement
		
		public function Destroyer() 
		{
			
		}
		
		override protected function onCanMove():void
		{
			if (this.scene.getSceneCell(new CellXY(this.x + 1, this.y)) != SceneFeature.FALL)
				this.callMove(item, this.forward);
			else
				this.jumpActor(item, this.jump);
		}
	}

}