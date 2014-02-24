package chaotic.scene 
{
	
	internal class ChunkPack implements IKnowAllTheWords 
	{
		internal static const MERGED_WORDS:int = 17;
		
		public var chunks:Vector.<Chunk>;
		
		
		private var words:Vector.<int>;
		
		
		public function ChunkPack() 
		{
			this.words = new Vector.<int>(ChunkPack.MERGED_WORDS);
			
			for (var i:int = 0; i < this.words.length; i++)
			{
				var n:int = 1;
				this.words[i] = 0;
				for (var j:int = 0; j < Chunk.WORD_WIDTH * Chunk.WORD_WIDTH; j++)
				{
					this.words[i] += n * Scene.road;
					n *= 2;
				}
			}
		}
		
		
		public function getCellFromTheWord(word:int, rotation:int, x:int, y:int):int 
		{
			var tmp:uint;
			
			if (rotation == 0)
				tmp = y * Chunk.WORD_WIDTH + x;	
			else if (rotation == 1)
				tmp = x * Chunk.WORD_WIDTH + (Chunk.WORD_WIDTH - (1 + y));	
			else if (rotation == 2)
				tmp = (Chunk.WORD_WIDTH - (1 + x)) + Chunk.WORD_WIDTH * (Chunk.WORD_WIDTH - 1 - y);	
			else if (rotation == 3)
				tmp = Chunk.WORD_WIDTH * (Chunk.WORD_WIDTH - x) - (1 + y);
				
			return (this.words[word] >> tmp) & 1;
		}
		
		public function randomizeWords():void
		{
			for (var i:int = 0; i < this.words.length; i++)
			{
				var n:int = 1;
				this.words[i] = 0;
				for (var j:int = 0; j < Chunk.WORD_WIDTH * Chunk.WORD_WIDTH; j++)
				{
					this.words[i] += n * getRandomSceneType();
					n *= 2;
				}
			}
			
			function getRandomSceneType():int
			{
				var tmp:int = int(Math.random() * 100000);
				
				if (tmp > 75000)
					tmp = Scene.fall;
				else tmp = Scene.road;
				
				return tmp;
			}
		}
		
		public function moveDown():void
		{
			var tmp:Chunk;
			var i:int;
			
			tmp = this.chunks[0];
			
			for (i = 1; i < Scene.MERGED_CHUNKS; i++)
			{
				this.chunks[i - 1] = this.chunks[i];
			}
			
			this.chunks[Scene.MERGED_CHUNKS - 1] = tmp;
		}
		
		public function moveUp():void
		{
			var tmp:Chunk;
			var i:int;
			
			tmp = this.chunks[Scene.MERGED_CHUNKS - 1];
			
			for (i = 1; i < Scene.MERGED_CHUNKS; i++)
			{
				this.chunks[Scene.MERGED_CHUNKS - i] = this.chunks[Scene.MERGED_CHUNKS - (i + 1)];
			}
			
			this.chunks[0] = tmp;
		}
	}

}