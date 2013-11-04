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
			this.sprites = new Vector.<Vector.<Vector.<Image>>>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			var i:int, j:int;
			
			for (i = 0; i < Game.NUMBER_OF_ITEM_TYPES; i++)
			{
				this.sprites[i] = new Vector.<Vector.<Image>>(Game.NUMBER_OF_ITEM_OCCUPATIONS, true);
				
				for (j = 0; j < Game.NUMBER_OF_ITEM_OCCUPATIONS; j++)
					this.sprites[i][j] = new Vector.<Image>();
			}
			
			var atlas:TextureAtlas = assets.getTextureAtlas("sprites");
			
			var spritelist:Vector.<Array> = new < Array > [
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_FREE, "hero_stand"),
					new Array(Game.ITEM_CHARACTER, Game.OCCUPATION_MOVING, "hero_side_0_0"),
					new Array(Game.ITEM_JUNK, Game.OCCUPATION_FREE, "unimplemented", "unimplemented")];
			
			
			//TODO: enlist sprites here
			
			
			var length:int = spritelist.length;
			for (i = 0; i < length; i++)
			{
				var jLength:int = spritelist[i].length;
				var type:int = spritelist[i][0];
				var occupation:int = spritelist[i][1];
				
				for (j = 2; j < jLength; j++)
				{
					var spritename:String = spritelist[i][j];
					
					this.sprites[type][occupation].push(new Image(atlas.getTexture(spritename)));
				}
			}
		}
		
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var center:ICoordinated = this.points.getCharacter();
			
			const tlcX:int = center.x - 13;
			const tlcY:int = center.y - 11;
			
			const brcX:int = center.x + 14;
			const brcY:int = center.y + 12;
			
			var sprite:Image;
			
			for (var i:int = tlcX; i < brcX; i++)
				for (var j:int = tlcY; j < brcY; j++)
				{
					var item:PuppetBase = this.items.findObjectByCell(i, j);
					
					if (item)
					{
						sprite = this.sprites[item.type][item.occupation][0];//TODO: implement scaling from progress
						
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
						if (item.occupation == Game.OCCUPATION_MOVING)
						{
							var dX:int = item.x - item.previousPosition.x;
							var dY:int = item.y - item.previousPosition.y;
							
							var progress:Number = 1 - item.getMoveProgress(frame);
							
							sprite.x -= int(progress * Game.CELL_WIDTH * dX);
							sprite.y -= int(progress * Game.CELL_HEIGHT * dY);
						}
						
						if (item.type == Game.ITEM_CHARACTER)
							sprite.y -= Game.CELL_HEIGHT;
						
						this.addImage(sprite);
					}
					
				}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
	}

}