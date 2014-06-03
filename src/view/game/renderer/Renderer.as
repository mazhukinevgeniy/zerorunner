package view.game.renderer 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.IStatus;
	import model.items.ItemSnapshot;
	import model.metric.ICoordinated;
	import starling.display.DisplayObjectContainer;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import utils.HeroChecker;
	import view.game.renderer.effects.EffectRenderer;
	import view.game.renderer.items.ItemRenderer;
	import view.game.renderer.marks.GroundLevelMarksRenderer;
	import view.game.renderer.projectiles.ProjectileRenderer;
	import view.game.renderer.scene.SceneRenderer;
	
	public class Renderer extends Sprite implements IRenderer
	{
		private var status:IStatus;
		
		private var sceneRenderer:SceneRenderer;
		private var activeRenderers:Vector.<IRenderer>;
		
		private var checker:HeroChecker;
		
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
			
			this.checker = new HeroChecker(binder);
			
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME, this.gameFrame);
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_FRAME, this.gameFrame);
		}
		
		private function gameFrame():void 
		{
			if (this.checker.checkIfHeroMoved())
			{
				this.sceneRenderer.redraw();
			}
			
			for (var i:int = 0; i < this.activeRenderers.length; i++)
				this.activeRenderers[i].redraw();
		}
		
		public function redraw():void
		{
			var hero:ItemSnapshot = this.status.getSnapshotOfHero();
			
			this.x = -hero.x * View.CELL_WIDTH + (View.WIDTH - View.CELL_WIDTH) / 2;
            this.y = -hero.y * View.CELL_HEIGHT + (View.HEIGHT - View.CELL_HEIGHT) / 2;
		}
	}

}