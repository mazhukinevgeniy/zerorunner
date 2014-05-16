package view.game.renderer 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import model.status.NumericalDxyHelper;
	import starling.display.DisplayObjectContainer;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class Renderer extends Sprite implements IRenderer, 
	                                                INewGameHandler,
													IGameFrameHandler
	{
		private var status:IStatus;
		
		private var sceneRenderer:SceneRenderer;
		private var activeRenderers:Vector.<IRenderer>;
		
		public function Renderer(binder:IBinder, root:DisplayObjectContainer) 
		{
			super();
			
			this.status = binder.gameStatus;
			
			this.activeRenderers = new Vector.<IRenderer>();
			this.activeRenderers.push(root.addChild(this));
			
			this.addChild(
				this.sceneRenderer = 
					new SceneRenderer(binder));
			
			this.activeRenderers.push(
				this.addChild(
					new GroundLevelMarksRenderer(binder)));
			this.activeRenderers.push(
				this.addChild(
					new ItemRenderer(binder)));
			this.activeRenderers.push(
				this.addChild(
					new ProjectileRenderer(binder)));
			this.activeRenderers.push(
				this.addChild(
					new EffectRenderer(binder)));
			
			binder.notifier.addObserver(this);
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
				this.sceneRenderer.redraw();
			}
			
			for (var i:int = 0; i < this.activeRenderers.length; i++)
				this.activeRenderers[i].redraw();
		}
		
		public function redraw():void
		{
			var cell:ICoordinated = this.status.getLocationOfHero();
			
			this.x = -cell.x * View.CELL_WIDTH + (View.WIDTH - View.CELL_WIDTH) / 2;
            this.y = -cell.y * View.CELL_HEIGHT + (View.HEIGHT - View.CELL_HEIGHT) / 2;
			
			var displacement:NumericalDxyHelper = this.status.getDisplacementOfHero();
			
			this.x -= int(View.CELL_WIDTH * displacement.dx);
			this.y -= int(View.CELL_HEIGHT * displacement.dy);
		}
	}

}