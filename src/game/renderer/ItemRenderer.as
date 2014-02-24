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
	import starling.utils.AssetManager;
	import utils.updates.update;
	
	internal class ItemRenderer extends QuadBatch
	{
		private const TOP:int = 0;
		private const DOWN:int = 1;
		private const LEFT:int = 2;
		private const RIGHT:int = 3; /* Please note: this is the default direction */
		
		private var items:Items;
		
		private var center:ICoordinated;
		
		private var sprites:Vector.<Vector.<Vector.<Vector.<Image>>>>;
		private var altsprites:Vector.<Vector.<Vector.<Vector.<Image>>>>;
		
		public function ItemRenderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.items = elements.items;
			
			this.initializeSprites(elements.assets);
		}
		
		private function initializeSprites(assets:AssetManager):void
		{
			this.initializeVectors("sprites");
			this.initializeVectors("altsprites");
			
			var atlas:TextureAtlas = assets.getTextureAtlas("sprites");
			
			var spritelist:Vector.<Array> = new < Array > 
					[
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.RIGHT, "hero_stand"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.TOP, "hero_stand"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.LEFT, "hero_stand"),//TODO: add other textures
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, this.DOWN, "hero_stand"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.LEFT, "hero_side_0_0", "hero_side_0_1"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.RIGHT, "hero_side_0_0", "hero_side_0_1"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.TOP, "hero_side_0_0", "hero_side_0_1"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.DOWN, "hero_side_0_0", "hero_side_0_1"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.RIGHT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.TOP, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.LEFT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLOATING, this.DOWN, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.LEFT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.RIGHT, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.TOP, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FLYING, this.DOWN, "unimplemented"),
						new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_DYING, this.RIGHT, "unimplemented"),
						
						new Array(Game.ITEM_BEACON, Game.OCCUPATION_FREE, this.RIGHT, "tow1"),
						new Array(Game.ITEM_BEACON, Game.OCCUPATION_DYING, this.RIGHT, "tow1"),
						
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_FREE, this.RIGHT, "standing_shard"),
						new Array(Game.ITEM_SHARD, Game.OCCUPATION_DYING, this.RIGHT, "standing_shard"),
						
						new Array(Game.ITEM_GENERATOR, Game.OCCUPATION_FREE, this.RIGHT, "unimplemented")
					];
			
			this.initializeImages(spritelist, this.sprites, atlas);
			
			var altspritelist:Vector.<Array> = new < Array > [
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, this.LEFT, "hero_side_1_0", "hero_side_1_1")];
			
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
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var center:ICoordinated = this.center;
			
			const tlcX:int = center.x - 13;//TODO: check if can reduce constants and/or hardcode
			const brcX:int = center.x + 14;
			
			const tlcY:int = center.y - 11;
			const brcY:int = center.y + 12;
			
			var sprite:Image;
			
			for (var j:int = tlcY; j < brcY; j++)
				for (var i:int = tlcX; i < brcX; i++)
				{
					var item:PuppetBase = this.items.findAnyObjectByCell(i, j);
					
					if (item)
					{
						sprite = this.getAnimationFrame(item, frame);
						
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
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
						
						this.addImage(sprite);
					}
					
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
		
		update function quitGame():void
		{
			this.reset();
			
			this.center = null;
		}
	}

}