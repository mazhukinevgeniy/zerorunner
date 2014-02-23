package game.renderer.clouds 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.PuppetBase;
	import game.metric.DCellXY;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import utils.updates.update;
	
	public class Clouds extends ScrollImage
	{
		internal static const SIZE_CLOUDINNESS_SCALE:int = 10;
		
		private var elements:GameElements;
		
		private var character:PuppetBase;
		
		public function Clouds(elements:GameElements) 
		{
			this.elements = elements;
			
			super(Main.WIDTH, Main.HEIGHT, false);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
		}
		
		update function restore(config:GameConfig):void
		{
			const numberOfClouds:int = 4;
			var cloudiness:int = config.cloudiness % Clouds.SIZE_CLOUDINNESS_SCALE;
			
			var cloudAtlas:CloudAtlas = new CloudAtlas(cloudiness);
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(cloudAtlas.getTexture("texture" + String(i + 1))));
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
				
				tile.alpha = 1/4;
			}
			
			this.x = this.y = 0;
		}
		
		update function setCenter(center:PuppetBase):void
		{
			this.character = center;
		}
		
		update function numberedFrame(frame:int):void 
		{
			this.tilesOffsetX = -this.character.x * Game.CELL_WIDTH + (Main.WIDTH - Game.CELL_WIDTH) / 2;
            this.tilesOffsetY = -this.character.y * Game.CELL_HEIGHT + (Main.HEIGHT - Game.CELL_HEIGHT) / 2;
			
			if (this.character.occupation == Game.OCCUPATION_MOVING ||
				this.character.occupation == Game.OCCUPATION_FLYING)
			{
				var dX:int = this.character.moveInProgress.x;
				var dY:int = this.character.moveInProgress.y;
				
				var progress:Number = 1 - this.character.getProgress(frame);
				
				this.tilesOffsetX += int(progress * Game.CELL_WIDTH * dX);
				this.tilesOffsetY += int(progress * Game.CELL_HEIGHT * dY);
			}
			
			
			for (var i:int = 0; i < this.numLayers; i++)
			{
				var cloud:Cloud = this.getLayerAt(i) as Cloud;
				
				
				cloud.offsetX = int(cloud.offsetX + cloud.dX);
				cloud.offsetY = int(cloud.offsetY + cloud.dY);
			}
		}
		
		update function quitGame():void
		{
			const dispose:Boolean = true;
			
			this.removeAll(dispose);
		}
	}

}