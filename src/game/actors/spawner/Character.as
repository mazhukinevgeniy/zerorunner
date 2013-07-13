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
		
		
		override protected function tryToMove(item:Puppet):void
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			while (action.x != 0 || action.y != 0)
			{
				if (this.landscape.getSceneCell(item.getCell().applyChanges(action)) != SceneFeature.FALL)
				{
					this.callMove(item, action);
					
					return;
				}
				
				action = tmp.pop();
			}
		}
		
		override protected function afterMoved(item:Puppet):void
		{
			this.flow.dispatchUpdate(InputManager.purgeClicks);
		}
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.kick(item, this.searcher.findObjectByCell(item.getCell().applyChanges(change)), change);
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.
		}
	}

}