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
		
		private var unimplemented:Image;
		private var hero_stand:Image;
		
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
			var atlas:TextureAtlas = assets.getTextureAtlas("sprites");
			
			var titles:Vector.<String> = new < String > 
										   ["unimplemented", "hero_stand"];
			
			var length:int = titles.length;
			for (var i:int = 0; i < length; i++)
			{
				this[titles[i]] = new Image(atlas.getTexture(titles[i]));
			}
		}
		
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var center:ICoordinated = this.points.getCharacter();
			
			const tlcX:int = center.x - 12;
			const tlcY:int = center.y - 10;
			
			const brcX:int = center.x + 13;
			const brcY:int = center.y + 11;
			
			var sprite:Image = this.unimplemented;
			
			for (var i:int = tlcX; i < brcX; i++)
				for (var j:int = tlcY; j < brcY; j++)
				{
					var item:PuppetBase = this.items.findObjectByCell(i, j);
					
					if (item)
					{
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
						if (item.occupation == Game.MOVING)
						{
							var dX:int = item.x - item.previousPosition.x;
							var dY:int = item.y - item.previousPosition.y;
							
							var progress:Number = 1 - item.getMoveProgress(frame);
							
							sprite.x -= int(progress * Game.CELL_WIDTH * dX);
							sprite.y -= int(progress * Game.CELL_HEIGHT * dY);
						}
						
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