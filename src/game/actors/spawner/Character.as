package game.actors.spawner 
{
	
	internal class Character 
	{
		private static const configuration = new XML
		(
			<actor>
				<type>0</type>
				<baseHP>100</baseHP>
				<speed>1</speed>
				<configuration>
					<check>NormalLandscapeCheck</check>
					<check>IsGrindedCheck</check>
					<action>MoveLikeACharacter</action>
				</configuration>
				<getCell>getSpawnCell</getCell>
				<chance>0</chance>
			</actor>
		);
		
		public function Character() 
		{
			super(Character.configuration);
		}
		
	}

}