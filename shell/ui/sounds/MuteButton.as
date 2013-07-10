package ui.sounds 
{
	import starling.display.Button;
	import starling.textures.Texture;
	
	internal class MuteButton extends Button 
	{
		private static const WIDTH:int = 50;
		private static const HEIGHT:int = 20;
		
		public function MuteButton() 
		{
			super(Texture.fromColor(MuteButton.WIDTH, MuteButton.HEIGHT, 0xFF987654), "Mute");
			
			this.fontName = "HiLo-Deco"; this.fontSize = 18;
			
			this.x = Main.WIDTH - MuteButton.WIDTH;
			this.y = Main.HEIGHT - MuteButton.HEIGHT;
		}
		
		public function toggleTitle():void
		{
			if (this.text == "Mute")
			{
				this.text = "Unmute";
			}
			else
			{
				this.text = "Mute";
			}
		}
		
	}	
}
