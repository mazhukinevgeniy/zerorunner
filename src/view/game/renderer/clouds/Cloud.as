package view.game.renderer.clouds 
{
	import starling.extensions.krecha.ScrollTile;
	import starling.textures.Texture;
	
	internal class Cloud extends ScrollTile
	{
		internal var dX:int;
		internal var dY:int;
		
		public function Cloud(texture:Texture)
		{
			do
			{
				this.dX = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
				this.dY = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
			}
			while (this.dX == 0 && this.dY == 0);
			
			super(texture);
		}
	}

}