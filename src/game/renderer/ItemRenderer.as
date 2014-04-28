package game.renderer 
{
	import game.GameElements;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.TextureAtlas;
	
	internal class ItemRenderer extends SubRendererBase
	{
		private const TOP:int = 0;
		private const DOWN:int = 1;
		private const LEFT:int = 2;
		private const RIGHT:int = 3; /* Please note: this is the default direction */
		
		private var items:Items;
		
		private var sprites:Vector.<Vector.<Vector.<Vector.<Image>>>>;
		private var altsprites:Vector.<Vector.<Vector.<Vector.<Image>>>>;
		
		public function ItemRenderer(elements:GameElements, layer:QuadBatch) 
		{
			super(elements, layer);
			
			this.items = elements.items;
			
			this.initializeSprites(elements.assets.getTextureAtlas("sprites"));
		}
		
		private function initializeSprites(atlas:TextureAtlas):void
		{
			this.initializeVectors("sprites");
			this.initializeVectors("altsprites");
			
			var spritelist:Vector.<Array> = new < Array > 
					[
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.RIGHT, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.TOP, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.LEFT, "side_dude"),//TODO: add other textures
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.DOWN, "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.LEFT, "side_dude", "side_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.RIGHT, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.TOP, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.DOWN, "front_dude", "front_dude"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.RIGHT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.TOP, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.LEFT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.DOWN, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.LEFT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.RIGHT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.TOP, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.DOWN, "unimplemented"),
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
			
			this.initializeImages(spritelist, this.sprites, atlas);
			
			var altspritelist:Vector.<Array> = new < Array > [
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.RIGHT, "front_dude", "front_dude")];
			
			this.initializeImages(altspritelist, this.altsprites, atlas);
			
			this.removeEmptyAnimations(this.altsprites);
		}
		
		private function initializeVectors(title:String):void
		{
			this[title] = new Vector.<Vector.<Vector.<Vector.<Image>>>>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			var i:int, j:int, k:int;
			
			for (i = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
			{
				this[title][i] = new Vector.<Vector.<Vector.<Image>>>(Game.NUMBER_OF_ITEM_OCCUPATIONS, true);
				
				for (j = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
				{
					this[title][i][j] = new Vector.<Vector.<Image>>(4, true);
					
					for (k = 0; k < 4; k++)
						this[title][i][j][k] = new Vector.<Image>();
				}
			}
		}
		
		private function initializeImages(list:Vector.<Array>, 
										  images:Vector.<Vector.<Vector.<Vector.<Image>>>>, 
										  atlas:TextureAtlas):void
		{
			var length:int = list.length;
			var i:int, j:int;
			
			for (i = 0; i < length; i++)
			{
				var jLength:int = list[i].length;
				var type:int = list[i][0];
				var occupation:int = list[i][1];
				var direction:int = list[i][2];
				
				for (j = 3; j < jLength; j++)
				{
					var spritename:String = list[i][j];
					
					images[type][occupation][direction].push(
						new Image(atlas.getTexture(spritename)));
				}
			}
		}
		
		private function removeEmptyAnimations(vector:Vector.<Vector.<Vector.<Vector.<Image>>>>):void
		{
			for (var i:int = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
				for (var j:int = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
					for (var k:int = 0; k < 4; k++)
						if (vector[i][j][k].length == 0)
							vector[i][j][k] = null;
		}
		
		override protected function get range():int 
		{
			return 8;
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			var item:PuppetBase = this.items.findAnyObjectByCell(x, y);
			
			if (item)
			{
				var sprite:Image = this.getAnimationFrame(item, frame);
				
				sprite.x = item.x * Game.CELL_WIDTH;
				sprite.y = item.y * Game.CELL_HEIGHT;
				
				if (item.occupation == Game.OCCUPATION_MOVING ||
					item.occupation == Game.OCCUPATION_FLYING)
				{
					var dX:int = item.moveInProgress.x;
					var dY:int = item.moveInProgress.y;
					
					var progress:Number = 1 - item.getProgress(frame);
					
					sprite.x -= int(progress * Game.CELL_WIDTH * dX);
					sprite.y -= int(progress * Game.CELL_HEIGHT * dY);
				}
				
				sprite.y += Game.CELL_HEIGHT - sprite.height;
				
				this.layer.addImage(sprite);
			}
		}
		
		private function getAnimationFrame(item:PuppetBase, flashFrame:int):Image
		{
			var type:int = item.type;
			var occupation:int = item.occupation;
			var direction:int = this.getDirection(item);
			
			var animationLength:int = this.sprites[type][occupation][direction].length;
			var frame:int = int(item.getProgress(flashFrame) * animationLength);
			
			var toReturn:Image = this.sprites[type][occupation][direction][frame];
			
			if (this.altsprites[type][occupation][direction] && item.isLastFrame(flashFrame))
				this.swapAnimations(type, occupation, direction);
			
			return toReturn;
		}
		
		private function swapAnimations(type:int, occupation:int, direction:int):void
		{
			var tmp:Vector.<Image> = this.altsprites[type][occupation][direction];
			
			this.altsprites[type][occupation][direction] = this.sprites[type][occupation][direction];
			this.sprites[type][occupation][direction] = tmp;
			
			//TODO: make sure it's either used or removed
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