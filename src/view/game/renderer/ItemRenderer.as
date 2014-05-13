package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.IPuppets;
	import model.items.PuppetBase;
	import model.metric.DCellXY;
	import starling.display.QuadBatch;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class ItemRenderer extends SubRendererBase
	{
		private const TOP:int = 0;
		private const DOWN:int = 1;
		private const LEFT:int = 2;
		private const RIGHT:int = 3; /* Please note: this is the default direction */
		
		private var puppets:IPuppets;
		
		private var sprites:Vector.<Vector.<Vector.<Vector.<CenteredImage>>>>;
		
		public function ItemRenderer(binder:IBinder, layer:QuadBatch) 
		{
			this.puppets = binder.puppets;
			
			this.sprites = new Vector.<Vector.<Vector.<Vector.<CenteredImage>>>>(Game.NUMBER_OF_ITEM_TYPES, true);
			this.initializeVectors(this.sprites);
			
			this.initializeSprites(binder.assetManager);
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 2);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, layer, changes);
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
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_UNSTABLE, this.RIGHT, "unimplemented"),
						
						new Array(Game.ITEM_BEACON, Game.OCCUPATION_FREE, this.RIGHT, "radar"),
						new Array(Game.ITEM_BEACON, Game.OCCUPATION_DYING, this.RIGHT, "radar"),
						
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_FREE, this.RIGHT, "stone_down"),
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_DYING, this.RIGHT, "stone_down"),
						
						new Array(Game.ITEM_CHECKPOINT, Game.OCCUPATION_FREE, this.RIGHT, "unimplemented"),
						new Array(Game.ITEM_CHECKPOINT, Game.OCCUPATION_UNSTABLE, this.RIGHT, "unimplemented"),
						
						new Array(Game.ITEM_THE_GOAL, Game.OCCUPATION_FREE, this.RIGHT, "side_dude"),
						new Array(Game.ITEM_THE_GOAL, Game.OCCUPATION_UNSTABLE, this.RIGHT, "side_dude")
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
		
		override protected function renderCell(x:int, y:int):void 
		{
			var item:PuppetBase = this.puppets.findAnyObjectByCell(x, y);
			
			if (item)
			{
				var sprite:CenteredImage = this.getAnimationFrame(item);
				
				var sx:int = x * View.CELL_WIDTH;
				var sy:int = y * View.CELL_HEIGHT;
				
				if (item.occupation == Game.OCCUPATION_MOVING)
				{
					var dX:int = item.moveInProgress.x;
					var dY:int = item.moveInProgress.y;
					
					var progress:Number = 1 - item.getProgress();
					
					sx -= int(progress * View.CELL_WIDTH * dX);
					sy -= int(progress * View.CELL_HEIGHT * dY);
				}
				
				sy += View.CELL_HEIGHT - sprite.height;
				
				sprite.x = sx;
				sprite.y = sy;
				
				this.layer.addImage(sprite);
			}
		}
		
		private function getAnimationFrame(item:PuppetBase):CenteredImage
		{
			var type:int = item.type;
			var occupation:int = item.occupation;
			var direction:int = this.getDirection(item);
			
			var animationLength:int = this.sprites[type][occupation][direction].length;
			var frame:int = int(item.getProgress() * animationLength);
			
			return this.sprites[type][occupation][direction][frame];
		}
		
		private function getDirection(item:PuppetBase):int
		{
			var change:DCellXY = item.moveInProgress;
			
			if (change.x < 0)
				return this.LEFT;
			else if (change.y > 0)
				return this.DOWN;
			else if (change.y < 0)
				return this.TOP;
			else 
				return this.RIGHT;
		}
	}

}