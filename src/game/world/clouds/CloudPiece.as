package game.world.clouds 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class CloudPiece extends Sprite
	{
		
		public function CloudPiece(numberOfElements:int, sprite:DisplayObject)
		{
			var size:Number = Math.sqrt(numberOfElements);
			
			this.width = (size * sprite.width * 4) / 3;
			this.height = (size * sprite.height * 4) / 3;
			
			for (var i:int = 0; i < numberOfElements; ++i)
			{
				var element:DisplayObject = sprite;
				this.addChild(element);
				
				element.x = Math.random() * (this.width - sprite.width);
				element.y = Math.random() * (this.height - sprite.height);
			}
		}
		
	}

}