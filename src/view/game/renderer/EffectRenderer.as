package view.game.renderer 
{
	import binding.IBinder;
	import controller.observers.game.INewGameHandler;
	import controller.observers.projectiles.IShardObserver;
	import model.projectiles.Projectile;
	import model.utils.normalize;
	import starling.display.QuadBatch;
	import starling.extensions.CenteredImage;
	
	internal class EffectRenderer extends SubRendererBase implements INewGameHandler,
	                                                                 IShardObserver
	{
		private const STONE_BOOM_LENGTH:int = 6;
		private const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		private var sprites:Object;
		
		private var shards:Array;
		
		public function EffectRenderer(binder:IBinder, layer:QuadBatch) 
		{
			binder.notifier.addObserver(this);
			
			var spriteNames:Array = new Array();
			this.sprites = new Object();
			
			for (var i:int = 1; i < 7; i++)
				spriteNames.push("stone_boom_" + String(i));
			
			for each (var key:String in spriteNames)
			{
				this.sprites[key] = new CenteredImage(key, binder.assetManager);
			}
			
			this.shards = new Array();
			
			
			super(binder, layer);
		}
		
		public function newGame():void
		{
			this.shards = new Array();
		}
		
		private function getShardAnimationFrame(x:int, y:int):int
		{
			return this.shards[normalize(x) + normalize(y) * Game.MAP_WIDTH];
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			this.shards[shard.cell.x + Game.MAP_WIDTH * shard.cell.y] = 
				this.STONE_BOOM_LENGTH * this.STONE_BOOM_SPEED_FACTOR;
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var key:int = normalize(x) + normalize(y) * Game.MAP_WIDTH;
			
			if (this.shards[key] > this.STONE_BOOM_SPEED_FACTOR)
			{
				x *= Game.CELL_WIDTH;
				y *= Game.CELL_HEIGHT;
				
				var sprite:CenteredImage = this.sprites["stone_boom_" + String(this.STONE_BOOM_LENGTH + 1 - int(this.shards[key] / this.STONE_BOOM_SPEED_FACTOR))];
				
				sprite.x = x + (Game.CELL_WIDTH - sprite.width) / 2;
				sprite.y = y + (Game.CELL_HEIGHT - sprite.height) / 2;
				
				this.layer.addImage(sprite);
				
				this.shards[key]--;
			}
		}
		
		override protected function get range():int 
		{
			return 9;
			/* A little extra, so we can avoid reasonable care for paused explosions */
		}
	}

}