package view.game.renderer.items 
{
	import binding.IBinder;
	import model.interfaces.IItemSnapshotter;
	import model.items.ItemSnapshot;
	import model.metric.DCellXY;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.getCellId;
	import utils.normalize;
	import view.game.renderer.structs.Changes;
	import view.game.renderer.SubRendererBase;
	
	public class ItemRenderer extends SubRendererBase
	{
		private const TOP:int = Game.DIRECTION_TOP;
		private const DOWN:int = Game.DIRECTION_DOWN;
		private const LEFT:int = Game.DIRECTION_LEFT;
		private const RIGHT:int = Game.DIRECTION_RIGHT; 
		/* Please note: right is the default direction */
		
		private var items:IItemSnapshotter;
		
		private var sprites:Vector.<Vector.<Vector.<Vector.<CenteredImage>>>>;
		
		/**
		 * Cells we've drawn since the last reset
		 */
		private var cells:Vector.<int>;
		
		public function ItemRenderer(binder:IBinder) 
		{
			this.items = binder.itemSnapshotter;
			
			this.sprites = new Vector.<Vector.<Vector.<Vector.<CenteredImage>>>>(Game.NUMBER_OF_ITEM_TYPES, true);
			this.initializeVectors(this.sprites);
			
			this.initializeSprites(binder.assetManager);
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			
			this.cells = new Vector.<int>();
			
			super(binder, changes);
		}
		
		private function initializeSprites(assets:AssetManager):void
		{
			var spritelist:Vector.<Array> = new < Array > 
					[
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.RIGHT, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.TOP, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.LEFT, "side_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.DOWN, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.LEFT, "side_dude", "side_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.TOP, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.RIGHT, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.DOWN, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_UNSTABLE, this.RIGHT, "hero_unstable"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_UNSTABLE, this.TOP, "hero_unstable"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_UNSTABLE, this.LEFT, "hero_unstable"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_UNSTABLE, this.DOWN, "hero_unstable"),
						
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_FREE, this.RIGHT, "stone_down"),
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_UNSTABLE, this.RIGHT, "stone_down"),
						
						new Array(Game.ITEM_THE_GOAL, Game.OCCUPATION_FREE, this.RIGHT, "tmp_goal"),
						new Array(Game.ITEM_BEACON, Game.OCCUPATION_FREE, this.RIGHT, "radar"),
						new Array(Game.ITEM_THE_SPAWN, Game.OCCUPATION_FREE, this.RIGHT, "spawn")
					];
			
			var atlas:TextureAtlas = assets.getTextureAtlas(View.MAIN_ATLAS);
			var offsets:XML = assets.getXml(View.MAIN_OFFSETS);
			
			var length:int = spritelist.length;
			var i:int, j:int;
			
			for (i = 0; i < length; i++)
			{
				var jLength:int = spritelist[i].length;
				var type:int = spritelist[i][0];
				var occupation:int = spritelist[i][1];
				var direction:int = spritelist[i][2];
				
				for (j = 3; j < jLength; j++)
				{
					var spritename:String = spritelist[i][j];
					
					this.sprites[type][occupation][direction].push(
						new CenteredImage(atlas.getTexture(spritename), offsets[spritename]));
				}
			}
		}
		
		private function initializeVectors(vector:Vector.<Vector.<Vector.<Vector.<CenteredImage>>>>):void
		{
			var i:int, j:int, k:int;
			
			for (i = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
			{
				vector[i] = new Vector.<Vector.<Vector.<CenteredImage>>>(Game.NUMBER_OF_ITEM_OCCUPATIONS, true);
				
				for (j = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
				{
					vector[i][j] = new Vector.<Vector.<CenteredImage>>(4, true);
					
					for (k = 0; k < 4; k++)
						vector[i][j][k] = new Vector.<CenteredImage>();
				}
			}
		}
		
		override public function reset():void 
		{
			super.reset();
			
			this.cells.length = 0;
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var item:ItemSnapshot = this.items.getItemSnapshot(getCellId(x, y));
			
			if (item)
			{
				if (item.width > 1 || item.height > 1)
				{
					/* Then item is stationary */
					
					var trueId:int = getCellId(item.x, item.y);
					
					if (this.cells.indexOf(trueId) != -1)
					{
						return;
					}
					else
					{
						this.cells.push(trueId);
					}
				}
				
				var trueX:int = normalize(x);
				var trueY:int = normalize(y);
				
				var sprite:CenteredImage = this.getAnimationFrame(item);
				
				var sx:int = (item.x - trueX + x) * View.CELL_WIDTH;
				var sy:int = (item.y - trueY + y) * View.CELL_HEIGHT;
				
				sy += (View.CELL_HEIGHT - sprite.height);
				sy += (item.height - 1) * View.CELL_HEIGHT;
				
				sprite.x = sx;
				sprite.y = sy;
				
				this.addImage(sprite);
			}
		}
		
		private function getAnimationFrame(item:ItemSnapshot):CenteredImage
		{
			var type:int = item.type;
			var occupation:int = item.occupation;
			var direction:int = item.direction;
			
			var animationLength:int = this.sprites[type][occupation][direction].length;
			var frame:int = animationLength == 1 ? 
			                0 : 
							int(item.progress * animationLength);
			
			return this.sprites[type][occupation][direction][frame];
		}
	}

}