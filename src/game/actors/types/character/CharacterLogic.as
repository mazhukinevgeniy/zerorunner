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
		private const HP:int = 100;
		
		private var input:IKnowInput;
		
		public function CharacterLogic(input:IKnowInput) 
		{
			super(new CharacterView());
			
			this.input = input;
		}
		
		override protected function getConfig():ConfigKit
		{
			return new ConfigKit(this.HP, 1, 1000);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return ActorsFeature.SPAWN_CELL;
		}
		
		override protected function onSpawned():void
		{
			this.flow.dispatchUpdate(ActorsFeature.setCenter, this);
			this.flow.dispatchUpdate(ActorsFeature.setHeroHP, this.HP);
		}
		
		override protected function onMoved(change:DCellXY, delay:int):void
		{
			this.flow.dispatchUpdate(ActorsFeature.moveCenter, change, delay + 1);
		}
		
		override protected function onDestroyed():void
		{
			this.flow.dispatchUpdate(ZeroRunner.gameOver);
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
			var gx:int = this.x + change.x;
			var gy:int = this.y + change.y;
			
			this.world.findObjectByCell(gx, gy).applyPush();
			
			if (!this.world.findObjectByCell(gx, gy))
			{
				this.move(change);
			}
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.flow.dispatchUpdate(ActorsFeature.heroDamaged, damage);
		}
	}

}