package game.renderer 
{
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.ItemBase;
	import game.items.Items;
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
		
		private var sprites:Object; //TODO: optimize by using vector and int keys
		
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
			
			this.sprites = new Object();
			
			var length:int = titles.length;
			for (var i:int = 0; i < length; i++)
			{
				this.sprites[titles[i]] = new Image(atlas.getTexture(titles[i]));
			}
		}
		
		
		update function numberedFrame(key:int):void
		{
			this.redraw();
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function redraw():void
		{
			this.reset();
			
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 12;
			const tlcY:int = center.y - 10;
			
			const brcX:int = center.x + 13;
			const brcY:int = center.y + 11;
			
			var sprite:Image = this.sprites.unimplemented;
			
			for (var i:int = tlcX; i < brcX; i++)
				for (var j:int = tlcY; j < brcY; j++)
					if (this.items.findObjectByCell(i, j))
					{
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						this.addImage(sprite);
					}
			
			//TODO: find and render everyone
		}
	}

}