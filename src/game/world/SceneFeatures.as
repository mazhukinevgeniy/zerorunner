package game.world 
{
	import flash.utils.ByteArray;
	import game.IGame;
	import game.world.patterns.FlatPattern;
	import game.world.patterns.getPattern;
	import game.world.patterns.IPattern;
	import utils.updates.update;
	
	internal class SceneFeatures 
	{
		private var scene:ByteArray;
		private var width:int;
		
		private var game:IGame;
		
		public function SceneFeatures(game:IGame) 
		{
			this.scene = new ByteArray();
			
			this.game = game;
		}
		
		update function prerestore():void
		{
			this.width = (this.game.getMapWidth() + 2) * Game.SECTOR_WIDTH;
			const secondJGoal:int = this.width - Game.SECTOR_WIDTH;
			
			const NUMBER_OF_PATTERNS:int = 23;
			const FLAT_STEP:int = int(NUMBER_OF_PATTERNS / 4);
			var j:int, i:int;
			
			var patterns:Vector.<IPattern> = new Vector.<IPattern>(NUMBER_OF_PATTERNS, true);
			for (i = 0; i < NUMBER_OF_PATTERNS; i++)
				patterns[i] = getPattern();
			for (i = int(Math.random() * FLAT_STEP), j = 0; i < NUMBER_OF_PATTERNS && j < 4; j++, i += 1 + int(Math.random() * FLAT_STEP))
				patterns[i] = new FlatPattern();
			
			this.scene.length = this.width * this.width;
			
			
			for (j = 0; j < Game.SECTOR_WIDTH; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			for (; j < secondJGoal; j++)
			{
				for (i = 0; i < Game.SECTOR_WIDTH; i++)
					this.scene[i + j * this.width] = Game.FALL;
				for (; i < secondJGoal; i++)
					this.scene[i + j * this.width] = patterns[uint((x * 84673) ^ (y * 108301)) % NUMBER_OF_PATTERNS].getNumber(i, j);
				for (; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			}
			for (; j < this.width; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			
			//TODO: check if start and finish are okay
			/*
			update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
			var tlcX:int = center.x - width / 2;
			var tlcY:int = center.y - height / 2;
			
			var center1:CellXY = ActorsFeature.SPAWN_CELL;
			
			if (center1.x + this.RADIUS > tlcX &&
				center1.y + this.RADIUS > tlcY &&
				center1.x - this.RADIUS < tlcX + width &&
				center1.y - this.RADIUS < tlcY + height)
			{
				var xTop:int = Math.min(center1.x + this.RADIUS, tlcX + width);
				var yTop:int = Math.min(center1.y + this.RADIUS, tlcY + height);
				
				for (var i:int = Math.max(tlcX, center1.x - this.RADIUS); i < xTop; i++)
					for (var j:int = Math.max(tlcY, center1.y - this.RADIUS); j < yTop; j++)
					{
						cache[i - tlcX + (j - tlcY) * width] = SceneFeature.ROAD;
					}
			}
			*/
		}
	}

}