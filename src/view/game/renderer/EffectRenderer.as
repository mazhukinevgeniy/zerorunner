package view.game.renderer 
{
	import binding.IBinder;
	import model.projectiles.Projectile;
	import starling.display.QuadBatch;
	import starling.extensions.CenteredImage;
	import view.game.renderer.utils.EffectTracker;
	
	internal class EffectRenderer extends SubRendererBase
	{
		private var sprites:Object;
		
		private var tracker:EffectTracker;
		
		public function EffectRenderer(binder:IBinder, layer:QuadBatch) 
		{
			this.tracker = new EffectTracker(binder);
			
			binder.notifier.addObserver(this);
			
			var spriteNames:Array = new Array();
			this.sprites = new Object();
			
			for (var i:int = 1; i < 7; i++)
				spriteNames.push("stone_boom_" + String(i));
			
			for each (var key:String in spriteNames)
			{
				this.sprites[key] = new CenteredImage(key, binder.assetManager);
			}
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 2);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, layer, changes);
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var shardFrame:int = this.tracker.getShardAnimationFrame(x, y);
			
			if (shardFrame < 7)
			{
				x *= View.CELL_WIDTH;
				y *= View.CELL_HEIGHT;
				
				var sprite:CenteredImage = this.sprites["stone_boom_" + String(shardFrame)];
				
				sprite.x = x + (View.CELL_WIDTH - sprite.width) / 2;
				sprite.y = y + (View.CELL_HEIGHT - sprite.height) / 2;
				
				this.layer.addImage(sprite);
			}
		}
		
	}

}