package game.renderer 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.PuppetBase;
	import game.renderer.clouds.Clouds;
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
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.numberedFrame);
			
			elements.displayRoot.addChild(this);
			elements.displayRoot.addChild(new Clouds(elements));
			
			this.addChild(new SceneRenderer(elements));
			this.addChild(new GroundLevelMarksRenderer(elements));
			this.addChild(new ItemRenderer(elements));
			this.addChild(new ProjectileRenderer(elements));
			this.addChild(new EffectRenderer(elements));
			
			elements.displayRoot.addChild(new PauseView(elements.flow));
		}
		
		update function setCenter(center:PuppetBase):void
		{
			this.character = center;
		}
		
		update function restore(config:GameConfig):void
		{
			/* Force rendering */
			
			this.update::numberedFrame(Game.FRAME_TO_ACT);
		}
		
		update function numberedFrame(frame:int):void 
		{
			this.x = -this.character.x * Game.CELL_WIDTH + (Main.WIDTH - Game.CELL_WIDTH) / 2;
            this.y = -this.character.y * Game.CELL_HEIGHT + (Main.HEIGHT - Game.CELL_HEIGHT) / 2;
			
			if (this.character.occupation == Game.OCCUPATION_MOVING ||
				this.character.occupation == Game.OCCUPATION_FLYING)
			{
				var dX:int = this.character.moveInProgress.x;
				var dY:int = this.character.moveInProgress.y;
				
				var progress:Number = 1 - this.character.getProgress(frame);
				
				this.x += int(progress * Game.CELL_WIDTH * dX);
				this.y += int(progress * Game.CELL_HEIGHT * dY);
			}
			
		}
	}

}