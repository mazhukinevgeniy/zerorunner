package game.ui.renderer 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.PuppetBase;
	import game.ui.renderer.clouds.Clouds;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import utils.updates.update;
	
	public class Renderer extends Sprite implements IRenderer
	{
		private var character:PuppetBase;
		
		private var renderers:Vector.<IRenderer>;
		
		private var sceneLayer:QuadBatch;
		private var activeLayer:QuadBatch;
		
		public function Renderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			
			this.renderers = new Vector.<IRenderer>();
			
			this.renderers.push(elements.displayRoot.addChild(this));
			
			this.addChild(this.sceneLayer = new QuadBatch());
			this.addChild(this.activeLayer = new QuadBatch());
			
			this.renderers.push(new SceneRenderer(elements, this.sceneLayer));
			
			this.renderers.push(new GroundLevelMarksRenderer(elements, this.activeLayer));
			this.renderers.push(new ItemRenderer(elements, this.activeLayer));
			this.renderers.push(new ProjectileRenderer(elements, this.activeLayer));
			this.renderers.push(new EffectRenderer(elements, this.activeLayer));
			
			this.renderers.push(this.addChild(new Clouds(elements)));
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
			if (frame == Game.FRAME_TO_ACT)
				this.sceneLayer.reset();
			
			this.activeLayer.reset();
			
			for each (var renderer:IRenderer in this.renderers)
				renderer.redraw(frame);
		}
		
		public function redraw(frame:int):void
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
		
		update function quitGame():void
		{
			this.sceneLayer.reset();
			this.activeLayer.reset();
		}
	}

}