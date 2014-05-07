package view.game.renderer 
{
	import data.IStatus;
	import data.NumericalDxyHelper;
	import game.GameElements;
	import game.interfaces.IRestorable;
	import game.metric.ICoordinated;
	import game.ui.renderer.clouds.Clouds;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import utils.updates.update;
	
	public class Renderer extends Sprite implements IRenderer, IRestorable
	{
		private var status:IStatus;
		
		private var sceneRenderer:SceneRenderer;
		private var activeRenderers:Vector.<IRenderer>;
		
		private var sceneLayer:QuadBatch;
		private var activeLayer:QuadBatch;
		
		public function Renderer(elements:GameElements) 
		{
			super();
			
			this.status = elements.status;
			
			elements.restorer.addSubscriber(this);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			
			this.activeRenderers = new Vector.<IRenderer>();
			
			this.activeRenderers.push(elements.displayRoot.addChild(this));
			
			this.addChild(this.sceneLayer = new QuadBatch());
			this.addChild(this.activeLayer = new QuadBatch());
			
			this.sceneRenderer = new SceneRenderer(elements, this.sceneLayer);
			
			this.activeRenderers.push(new GroundLevelMarksRenderer(elements, this.activeLayer));
			this.activeRenderers.push(new ItemRenderer(elements, this.activeLayer));
			this.activeRenderers.push(new ProjectileRenderer(elements, this.activeLayer));
			this.activeRenderers.push(new EffectRenderer(elements, this.activeLayer));
			
			this.activeRenderers.push(
				elements.displayRoot.addChild(new Clouds(elements, this)));
		}
		
		public function restore():void
		{
			/* Force rendering */
			
			this.update::numberedFrame(Game.FRAME_TO_ACT);
		}
		
		update function numberedFrame(frame:int):void 
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				this.sceneLayer.reset();
				this.sceneRenderer.redraw();
			}
			
			this.activeLayer.reset();
			
			for (var i:int = 0; i < this.activeRenderers.length; i++)
				this.activeRenderers[i].redraw();
		}
		
		public function redraw():void
		{
			var cell:ICoordinated = this.status.getLocationOfHero();
			
			this.x = -cell.x * Game.CELL_WIDTH + (Main.WIDTH - Game.CELL_WIDTH) / 2;
            this.y = -cell.y * Game.CELL_HEIGHT + (Main.HEIGHT - Game.CELL_HEIGHT) / 2;
			
			var displacement:NumericalDxyHelper = this.status.getDisplacementOfHero();
			
			this.x -= int(Game.CELL_WIDTH * displacement.dx);
			this.y -= int(Game.CELL_HEIGHT * displacement.dy);
		}
		
		update function quitGame():void
		{
			this.sceneLayer.reset();
			this.activeLayer.reset();
		}
	}

}