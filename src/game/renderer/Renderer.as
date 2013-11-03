package game.renderer 
{
	import game.GameElements;
	import game.items.PuppetBase;
	import starling.display.Sprite;
	import utils.updates.update;
	
	public class Renderer extends Sprite
	{
		private var character:PuppetBase;
		
		public function Renderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.displayRoot.addChild(this);
			
			this.addChild(new SceneRenderer(elements));
			this.addChild(new ItemRenderer(elements));
		}
		
		update function setCenter(center:PuppetBase):void
		{
			this.character = center;
		}
		
		//TODO: check if movecenter needs tickstogo
		//TODO: check if we need metric
		
		update function numberedFrame(frame:int):void 
		{
			this.x = -this.character.x * Game.CELL_WIDTH + (Main.WIDTH - Game.CELL_WIDTH) / 2;
            this.y = -this.character.y * Game.CELL_HEIGHT + (Main.HEIGHT - Game.CELL_HEIGHT) / 2;
			
			if (this.character.occupation == Game.MOVING)
			{
				var dX:int = this.character.x - this.character.previousPosition.x;
				var dY:int = this.character.y - this.character.previousPosition.y;
				
				var progress:Number = 1 - this.character.getMoveProgress(frame);
				
				this.x += int(progress * Game.CELL_WIDTH * dX);
				this.y += int(progress * Game.CELL_HEIGHT * dY);
			}
			
		}
	}

}