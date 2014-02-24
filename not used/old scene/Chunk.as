package chaotic.scene 
{
	
	internal class Chunk
	{
		internal static const WORD_WIDTH:int = 3;
		internal static const WORDS_PER_CHUNK:int = 7;
		internal static const WORDS_PER_CHUNKS_ROW:int = 9;
		
		internal static const CELLS_PER_ROW:int = Chunk.WORD_WIDTH * Chunk.WORDS_PER_CHUNKS_ROW;
		
		
		private static var count:int = 0;
		
		
		protected var words:Vector.<int>;
		protected var wordsBank:IKnowAllTheWords;
		
		protected var id:int;
		
		public function Chunk(newBank:IKnowAllTheWords, newWords:Vector.<int>) 
		{
			this.id = Chunk.count;
			Chunk.count++;
			
			this.words = newWords;
			
			this.wordsBank = newBank;
		}
		
		public function getCell(x:int, y:int):int
		{
			var wordX:int = int(x / Chunk.WORD_WIDTH);
			var wordY:int = int(y / Chunk.WORD_WIDTH);
			
			var greatNumber:int = (this.id * this.id * 1901 
								   + wordX * wordX * 1907 
								   + this.id * wordX * wordY * 2713 
								   + wordY * wordY * 1913);
			
			return this.wordsBank.getCellFromTheWord(this.words[greatNumber % Chunk.WORDS_PER_CHUNK],
													 greatNumber % 4,
													 x % Chunk.WORD_WIDTH, 
													 y % Chunk.WORD_WIDTH);
			
		}
		
		public function randomizeWords():void
		{
			var tmp:Vector.<int> = new Vector.<int>(Chunk.WORDS_PER_CHUNK, true);
			
			for (var j:int = 0; j < this.words.length; j++)
				tmp[j] = int(Math.random() * ChunkPack.MERGED_WORDS);
				
			this.words = tmp;
		}
		
	}

}