package game.renderer 
{
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.points.IPointCollector;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.update;
	
	internal class ItemRenderer extends QuadBatch
	{
		private var points:IPointCollector;
		private var items:Items;
		
		private var sprites:Vector.<Vector.<Vector.<Image>>>;
		private var altsprites:Vector.<Vector.<Vector.<Image>>>;
		
		public function ItemRenderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.points = elements.pointsOfInterest;
			this.items = elements.items;
			
			this.initializeSprites(elements.assets);
		}
		
		private function initializeSprites(assets:AssetManager):void
		{
			this.initializeVectors("sprites");
			this.initializeVectors("altsprites");
			
			var atlas:TextureAtlas = assets.getTextureAtlas("sprites");
			
			var spritelist:Vector.<Array> = new < Array > [
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, "hero_stand"),
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, "hero_side_0_0", "hero_side_0_1"),
					new Array(Game.ITEM_BEACON, Game.OCCUPATION_FREE, "tow1"),
					new Array(Game.ITEM_JUNK, Game.OCCUPATION_FREE, "unimplemented", "unimplemented")];
			//TODO: enlist sprites here
			
			this.initializeImages(spritelist, this.sprites, atlas);
			
			var altspritelist:Vector.<Array> = new < Array > [
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, "hero_side_1_0", "hero_side_1_1"),
					new Array(Game.ITEM_JUNK, Game.OCCUPATION_FREE, "unimplemented", "unimplemented")];
			
			this.initializeImages(altspritelist, this.altsprites, atlas);
			
			this.removeEmptyAnimations(this.altsprites);
		}
		
		private function initializeVectors(title:String):void
		{
			this[title] = new Vector.<Vector.<Vector.<Image>>>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			var i:int, j:int;
			
			for (i = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
			{
				this[title][i] = new Vector.<Vector.<Image>>(Game.NUMBER_OF_ITEM_OCCUPATIONS, true);
				
				for (j = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
					this[title][i][j] = new Vector.<Image>();
			}
		}
		
		private function initializeImages(list:Vector.<Array>, 
										  images:Vector.<Vector.<Vector.<Image>>>, 
										  atlas:TextureAtlas):void
		{
			var length:int = list.length;
			var i:int, j:int;
			
			for (i = 0; i < length; i++)
			{
				var jLength:int = list[i].length;
				var type:int = list[i][0];
				var occupation:int = list[i][1];
				
				for (j = 2; j < jLength; j++)
				{
					var spritename:String = list[i][j];
					
					images[type][occupation].push(new Image(atlas.getTexture(spritename)));
				}
			}
		}
		
		private function removeEmptyAnimations(vector:Vector.<Vector.<Vector.<Image>>>):void
		{
			for (var i:int = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
				for (var j:int = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
					if (vector[i][j].length == 0)
						vector[i][j] = null;
		}
		
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var center:ICoordinated = this.points.getCharacter();
			
			const tlcX:int = center.x - 13;
			const brcX:int = center.x + 14;
			
			const tlcY:int = center.y - 11;
			const brcY:int = center.y + 12;
			
			var sprite:Image;
			
			for (var j:int = tlcY; j < brcY; j++)
				for (var i:int = tlcX; i < brcX; i++)
				{
					var item:PuppetBase = this.items.findObjectByCell(i, j);
					
					if (item)
					{
						sprite = this.getAnimationFrame(item, frame);
						
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
						if (item.occupation == Game.OCCUPATION_MOVING)
						{
							var dX:int = item.x - item.previousPosition.x;
							var dY:int = item.y - item.previousPosition.y;
							
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
			
			var aLength:int = this.sprites[type][occupation].length;
			
			var frame:int = int(item.getProgress(flashFrame) * aLength);
			
			var toReturn:Image = this.sprites[type][occupation][frame];
			
			if (this.altsprites[type][occupation] && item.isLastFrame(flashFrame))
				this.swapAnimations(type, occupation);
			
			return toReturn;
		}
		
		private function swapAnimations(type:int, occupation:int):void
		{
			var tmp:Vector.<Image> = this.altsprites[type][occupation];
			
			this.altsprites[type][occupation] = this.sprites[type][occupation];
			this.sprites[type][occupation] = tmp;
		}
		
		update function quitGame():void
		{
			this.reset();
		}
	}

}