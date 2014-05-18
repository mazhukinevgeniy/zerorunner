package view.game.renderer.effects 
{
	import binding.IBinder;
	import model.projectiles.Projectile;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import view.game.renderer.structs.Changes;
	import view.game.renderer.structs.Effect;
	import view.game.renderer.SubRendererBase;
	
	public class EffectRenderer extends SubRendererBase
	{
		private const STONE_BOOM:String = "STONE_BOOM";
		
		internal static const STONE_BOOM_LENGTH:int = 6;
		internal static const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		
		private var sprites:Object;
		
		private var shardTracker:ShardTracker;
		
		public function EffectRenderer(binder:IBinder) 
		{
			this.shardTracker = new ShardTracker(binder);
			
			binder.notifier.addObserver(this);
			
			var spriteNames:Array = new Array();
			this.sprites = new Object();
			
			for (var i:int = 1; i < 7; i++)
				spriteNames.push("stone_boom_" + String(i));
			
			var assets:AssetManager = binder.assetManager;
			var atlas:TextureAtlas = assets.getTextureAtlas(View.MAIN_ATLAS);
			var offsets:XML = assets.getXml(View.MAIN_OFFSETS);
			
			for each (var key:String in spriteNames)
			{
				this.sprites[key] = new CenteredImage(atlas.getTexture(key), offsets[key]);
			}
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 2);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, changes);
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var effect:Effect;
			
			effect = this.shardTracker.getEffect(x, y);
			
			if (effect)
			{
				var frame:int = this.getEffectFrame(this.STONE_BOOM, effect.duration);
				
				var sprite:CenteredImage = this.sprites["stone_boom_" + String(frame)];
				
				sprite.x = x * View.CELL_WIDTH + (View.CELL_WIDTH - sprite.width) / 2;
				sprite.y = y * View.CELL_HEIGHT + (View.CELL_HEIGHT - sprite.height) / 2;
				
				this.addImage(sprite);
			}
		}
		
		private function getEffectFrame(type:String, duration:int):int
		{
			var frame:int = EffectRenderer[type + "_LENGTH"];
			
			frame += 1 - duration / EffectRenderer[type + "_SPEED_FACTOR"];
			
			return frame;
		}
	}

}