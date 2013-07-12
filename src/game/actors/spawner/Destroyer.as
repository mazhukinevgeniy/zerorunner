package game.actors.spawner 
{
	
	internal class Destroyer 
	{
		private static const configuration = new XML
		(
			<actor>
				<type>3</type>
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
		
		public function Destroyer() 
		{
			
		}
		
	}

}