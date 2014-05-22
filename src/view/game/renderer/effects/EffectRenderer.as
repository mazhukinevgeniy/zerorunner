package view.game.renderer.effects 
{
	import binding.IBinder;
	import model.projectiles.Projectile;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.getCellId;
	import view.game.renderer.structs.Changes;
	import view.game.renderer.SubRendererBase;
	
	public class EffectRenderer extends SubRendererBase
	{
		private const STONE_BOOM:String = "STONE_BOOM";
		private const COLLECTION:String = "COLLECTION";
		
		internal static const STONE_BOOM_LENGTH:int = 6;
		internal static const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		internal static const COLLECTION_LENGTH:int = 8;
		internal static const COLLECTION_SPEED_FACTOR:int = 5;
		
		
		private var sprites:Object;
		
		private var shardTracker:ShardTracker;
		private var collectionTracker:CollectionTracker;
		
		public function EffectRenderer(binder:IBinder) 
		{
			this.shardTracker = new ShardTracker(binder);
			this.collectionTracker = new CollectionTracker(binder);
			
			binder.notifier.addObserver(this);
			
			var spriteNames:Array = new Array();
			this.sprites = new Object();
			
			for (var i:int = 1; i < 7; i++)
				spriteNames.push("stone_boom_" + String(i));
			
			spriteNames.push("collection_eff");
			
			var assets:AssetManager = binder.assetManager;
			var atlas:TextureAtlas = assets.getTextureAtlas(View.MAIN_ATLAS);
			var offsets:XML = assets.getXml(View.MAIN_OFFSETS);
			
			for each (var key:String in spriteNames)
			{
				this.sprites[key] = new CenteredImage(atlas.getTexture(key), offsets[key]);
			}
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			
			super(binder, changes);
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var cellId:int = getCellId(x, y);
			
			var effect:Effect;
			var sprite:CenteredImage;
			
			effect = this.shardTracker.getEffect(cellId);
			
			if (effect)
			{
				var frame:int = this.getEffectFrame(this.STONE_BOOM, effect.duration);
				
				sprite = this.sprites["stone_boom_" + String(frame)];
				
				this.addSprite(sprite, x, y);
			}
			
			effect = this.collectionTracker.getEffect(cellId);
			
			if (effect)
			{
				sprite = this.sprites["collection_eff"];
				
				/* (0,1] */
				var timeLeft:Number = effect.duration / 
					(EffectRenderer.COLLECTION_LENGTH * 
					 EffectRenderer.COLLECTION_SPEED_FACTOR); 
				
				sprite.alpha = 0.75 * timeLeft;
				sprite.scaleX = sprite.scaleY = 1.5 - timeLeft;
				
				this.addSprite(sprite, x, y);
			}
		}
		
		private function addSprite(image:CenteredImage, x:int, y:int):void
		{
			image.x = x * View.CELL_WIDTH + (View.CELL_WIDTH - image.width) / 2;
			image.y = y * View.CELL_HEIGHT + (View.CELL_HEIGHT - image.height) / 2;
			
			this.addImage(image);
		}
		
		private function getEffectFrame(type:String, duration:int):int
		{
			var frame:int = EffectRenderer[type + "_LENGTH"];
			
			frame += 1 - duration / EffectRenderer[type + "_SPEED_FACTOR"];
			
			return frame;
		}
	}

}