package game.actors.types.character 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.actors.utils.ConfigKit;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	import game.ZeroRunner;
	
	internal class CharacterLogic extends ActorLogicBase
	{		
		private var input:IKnowInput;
		
		public function CharacterLogic(input:IKnowInput) 
		{
			super(new CharacterView());
			
			this.input = input;
		}
		
		override protected function getConfig():ConfigKit
		{
			var config:ConfigKit = new ConfigKit();
			
			config.health = 100;
			config.movingSpeed = 1;
			config.actingSpeed = 1000;
			
			return config;
		}
		
		override protected function getSpawningCell():CellXY
		{
			return ActorsFeature.SPAWN_CELL;
		}
		
		override protected function onSpawned():void
		{
			this.flow.dispatchUpdate(ActorsFeature.setCenter, this);
			this.flow.dispatchUpdate(ActorsFeature.setHeroHP, 100); //TODO: remove hardcode
		}
		
		override protected function onMoved(change:DCellXY, delay:int):void
		{
			this.flow.dispatchUpdate(ActorsFeature.moveCenter, change, delay + 1);
		}
		
		override protected function onDestroyed():void
		{
			this.flow.dispatchUpdate(ZeroRunner.gameOver);
			
			//this.forceActive(true);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround();
		}
		
		
		override protected function onCanMove():void
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			while (action.x != 0 || action.y != 0)
			{
				if (this.world.getSceneCell(this.x + action.x, this.y + action.y) != SceneFeature.FALL)
				{
					this.move(action);
					
					return;
				}
				else if (this.world.getSceneCell(this.x + 2 * action.x, this.y + 2 * action.y) != SceneFeature.FALL)
				{
					this.jump(action, 2);
					
					return;
				}
				
				action = tmp.pop();
			}
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			// TODO: implement pushing here or as an action (or somehow else)
			//this.kick(item, this.searcher.findObjectByCell(item.getCell().applyChanges(change)), change);
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.flow.dispatchUpdate(ActorsFeature.heroDamaged, damage);
		}
	}

}