package game.items.character 
{
	import game.items.base.cores.ExistenceCore;
	
	internal class Existence extends ExistenceCore
	{
		
		public function Existence() 
		{
			
		}
		
		override protected function move(change:DCellXY, delay:int):void
		{
			var actor:ItemBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
			if (!actor)
			{
				super.move(change, delay);
				this.view.animateWalking(change, delay);
				
				this.cooldown = this.MOVE_SPEED;
				
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
		}
		
		override public function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
	}

}