package view.shell.clouds 
{
	import binding.IBinder;
	import starling.events.EnterFrameEvent;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	
	public class Clouds extends ScrollImage
	{		
		private var usedAtlas:CloudAtlas;
		
		public function Clouds(binder:IBinder) 
		{
			super(View.WIDTH, View.HEIGHT, false);
			
			this.createClouds();
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, this.redraw);
		}
		
		public function createClouds():void
		{
			const numberOfClouds:int = 16;
			const cloudiness:int = 1;
			
			
			var cloudAtlas:CloudAtlas = this.usedAtlas = new CloudAtlas(cloudiness);
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(cloudAtlas.getTexture("texture" + String(i % 4 + 1))));
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
				
				tile.alpha = 1/8;
			}
		}
		
		private function redraw():void 
		{
			
			for (var i:int = 0; i < this.numLayers; i++)
			{
				if (Math.random() < 0.3)
				{
					var cloud:Cloud = this.getLayerAt(i) as Cloud;
					
					cloud.offsetX = int(cloud.offsetX + cloud.dX);
					cloud.offsetY = int(cloud.offsetY + cloud.dY);
				}
			}
		}
	}

}