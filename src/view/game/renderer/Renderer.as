package view.game.renderer 
{
	import binding.IBinder;
	import controller.observers.game.IGameFrameHandler;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import model.status.NumericalDxyHelper;
	import starling.display.DisplayObjectContainer;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import view.game.renderer.clouds.Clouds;
	
	public class Renderer extends Sprite implements IRenderer, 
	                                                INewGameHandler,
													IGameFrameHandler,
													IQuitGameHandler
	{
		private var status:IStatus;
		
		private var sceneRenderer:SceneRenderer;
		private var activeRenderers:Vector.<IRenderer>;
		
		private var sceneLayer:QuadBatch;
		private var activeLayer:QuadBatch;
		
		public function Renderer(binder:IBinder, root:DisplayObjectContainer) 
		{
			super();
			
			this.status = binder.gameStatus;
			
			binder.notifier.addGameStatusObserver(this);
			
			
			this.activeRenderers = new Vector.<IRenderer>();
			
			this.activeRenderers.push(root.addChild(this));
			
			this.addChild(this.sceneLayer = new QuadBatch());
			this.addChild(this.activeLayer = new QuadBatch());
			
			this.sceneRenderer = new SceneRenderer(binder, this.sceneLayer);
			
			this.activeRenderers.push(new GroundLevelMarksRenderer(binder, this.activeLayer));
			this.activeRenderers.push(new ItemRenderer(binder, this.activeLayer));
			this.activeRenderers.push(new ProjectileRenderer(binder, this.activeLayer));
			this.activeRenderers.push(new EffectRenderer(binder, this.activeLayer));
			
			this.activeRenderers.push(root.addChild(new Clouds(binder, this)));
		}
		
		public function newGame():void
		{
			/* Force rendering */
			
			this.gameFrame(Game.FRAME_TO_ACT);
		}
		
		public function gameFrame(frame:int):void 
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
		
		public function quitGame():void
		{
			this.sceneLayer.reset();
			this.activeLayer.reset();
		}
	}

}