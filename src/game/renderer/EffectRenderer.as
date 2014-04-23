package game.renderer 
{
	import game.GameElements;
	import game.projectiles.Projectile;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class EffectRenderer extends SubRendererBase
	{
		private const STONE_BOOM_LENGTH:int = 6;
		private const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		private var sprites:Object;
		
		private var shards:Array;
		
		public function EffectRenderer(elements:GameElements) 
		{
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.dropShard);
			
			var spriteNames:Array = new Array();
			this.sprites = new Object();
			
			for (var i:int = 1; i < 7; i++)
				spriteNames.push("stone_boom_" + String(i));
			
			var atlas:TextureAtlas = elements.assets.getTextureAtlas("sprites");
			
			for each (var key:String in spriteNames)
			{
				this.sprites[key] = new Image(atlas.getTexture(key));
			}
			
			this.shards = new Array();
			
			
			super(elements);
		}
		
		private function getShardAnimationFrame(x:int, y:int):int
		{
			return this.shards[normalize(x) + normalize(y) * Game.MAP_WIDTH];
		}
		
		update function dropShard(shard:Projectile):void
		{
			this.shards[shard.cell.x + Game.MAP_WIDTH * shard.cell.y] = this.STONE_BOOM_LENGTH * this.STONE_BOOM_SPEED_FACTOR;
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			var key:int = normalize(x) + normalize(y) * Game.MAP_WIDTH;
			
			if (this.shards[key] > this.STONE_BOOM_SPEED_FACTOR)
			{
				x *= Game.CELL_WIDTH;
				y *= Game.CELL_HEIGHT;
				
				var sprite:Image = this.sprites["stone_boom_" + String(this.STONE_BOOM_LENGTH + 1 - int(this.shards[key] / this.STONE_BOOM_SPEED_FACTOR))];
				
				sprite.x = x + (Game.CELL_WIDTH - sprite.width) / 2;
				sprite.y = y + (Game.CELL_HEIGHT - sprite.height) / 2;
				
				this.addImage(sprite);
				
				this.shards[key]--;
			}
		}
		
		override protected function get range():int 
		{
			return 9;
			/* A little extra, so we can avoid reasonable care for paused explosions */
		}
		
		override protected function handleGameStarted():void 
		{
			this.shards = new Array();
		}
	}

}