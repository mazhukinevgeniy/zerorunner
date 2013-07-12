package game.actors.spawner 
{
	
	internal class Guardian 
	{
		private static const configuration = new XML
		(
			<actor>
				<type>2</type>
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
		
		public function Guardian() 
		{
			
		}
		
	}

}