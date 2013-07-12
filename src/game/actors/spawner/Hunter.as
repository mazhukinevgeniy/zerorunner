package game.actors.spawner 
{
	
	internal class Hunter 
	{
		private static const configuration = new XML
		(
			<actor>
				<type>1</type>
				<baseHP>3</baseHP>
				<speed>2</speed>
				<configuration>
					<check>NormalLandscapeCheck</check>
					<check>OutOfBoundsCheck</check>
					<check>IsGrindedCheck</check>
					<action>HeuristicGoalPursuing</action>
				</configuration>
				<getCell>getRandomCell</getCell>
				<chance>0.3</chance>
			</actor>
		);
		
		
		
		public function Hunter() 
		{
			super(Hunter.configuration);
		}
		
	}

}