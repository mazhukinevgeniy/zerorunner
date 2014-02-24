package chaotic.scene 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.choosenArea.IChoosenArea;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.updates.IChunkDependant;
	import chaotic.updates.IInformerAdder;
	import chaotic.updates.IInformerGetter;
	import chaotic.updates.IRestorable;
	import chaotic.updates.Update;
	import chaotic.xml.getLandscapeXML;
	
	internal class Scene extends ChaoticFeature implements IScene, IInformerAdder, IRestorable, IChunkDependant, IInformerGetter
	{
		private static const CHUNKS_PER_ROW_ON_THE_MAP:int = 3;
		private static const WORDS_PER_MAP:int = Scene.CHUNKS_PER_ROW_ON_THE_MAP * ChunkPack.MERGED_WORDS;
		
		private static const CHUNKS_TOTAL:int = Scene.CHUNKS_PER_ROW_ON_THE_MAP * Scene.CHUNKS_PER_ROW_ON_THE_MAP;
		
		internal static const MERGED_CHUNKS:int = Scene.CHUNKS_TOTAL / Scene.CHUNKS_PER_ROW_ON_THE_MAP;
		
		
		private var area:IChoosenArea;
		
		internal static var fall:int;
		internal static var road:int;
		
		private var chunkPacks:Vector.<ChunkPack>;
		
		private var xDChunks:int;
		private var yDChunks:int;
		
		public function Scene() 
		{
			var landscape:XML = getLandscapeXML();
			Scene.fall = int(landscape.fall);
			Scene.road = int(landscape.road);
			
			this.chunkPacks = new Vector.<ChunkPack>(Scene.CHUNKS_PER_ROW_ON_THE_MAP, true);
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			if (Metric.isOutOfBounds(x, y))
				return Scene.fall;
			
			x -= this.xDChunks;
			y -= this.yDChunks;
			
			return this.chunkPacks[int(x / Chunk.CELLS_PER_ROW)]
					   .chunks[int(y / Chunk.CELLS_PER_ROW)]
					   .getCell(x % Chunk.CELLS_PER_ROW, y % Chunk.CELLS_PER_ROW);
		}
		
		public function restore():void
		{
			this.xDChunks = 0;
			this.yDChunks = 0;
			
			do
			{
				var i:int, j:int;
				
				
				for (i = 0; i < Scene.CHUNKS_PER_ROW_ON_THE_MAP; i++)
				{
					this.chunkPacks[i] = new ChunkPack();
				}
				
				var newChunks:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(Scene.CHUNKS_TOTAL, true);
				
				for (i = 0; i < Scene.CHUNKS_TOTAL; i++)
				{
					newChunks[i] = new Vector.<int>(Chunk.WORDS_PER_CHUNK, true);
					
					for (j = 0; j < Chunk.WORDS_PER_CHUNK; j++)
						newChunks[i][j] = int(Math.random() * ChunkPack.MERGED_WORDS);
				}
				
				for (i = 0; i < Scene.CHUNKS_PER_ROW_ON_THE_MAP; i++)
				{
					this.chunkPacks[i].chunks = new Vector.<Chunk>(Scene.MERGED_CHUNKS, true);
					
					for (j = i * Scene.MERGED_CHUNKS; j < (i + 1) * Scene.MERGED_CHUNKS; j++)
					{
						this.chunkPacks[i].chunks[j - i * Scene.MERGED_CHUNKS] = new Chunk(this.chunkPacks[i], newChunks[j]);
					}
				}
			}
			while (this.chunkPacks[int(40 / Chunk.CELLS_PER_ROW)]
						   .chunks[int(40 / Chunk.CELLS_PER_ROW)]
						   .getCell(40 % Chunk.CELLS_PER_ROW, 40 % Chunk.CELLS_PER_ROW) == 1);
		}
		
		
		public function moveChunks(change:DCellXY):void
		{
			var tmp:ChunkPack;
			var i:int;
			
			if (change.x == -1)
			{
				tmp = this.chunkPacks[Scene.CHUNKS_PER_ROW_ON_THE_MAP - 1];
				
				
				for (i = 0; i < Scene.MERGED_CHUNKS; i++)
				{
					tmp.chunks[i].randomizeWords();
					tmp.randomizeWords();
				}
				
				for (i = 1; i < Scene.CHUNKS_PER_ROW_ON_THE_MAP; i++)
				{
					this.chunkPacks[Scene.CHUNKS_PER_ROW_ON_THE_MAP - i] = this.chunkPacks[Scene.CHUNKS_PER_ROW_ON_THE_MAP - (i + 1)];
				}
				
				this.chunkPacks[0] = tmp;
			}
			else if (change.x == 1)
			{
				tmp = this.chunkPacks[0];
				
				for (i = 0; i < Scene.MERGED_CHUNKS; i++)
				{
					tmp.chunks[i].randomizeWords();
					tmp.randomizeWords();
				}
				
				for (i = 1; i < Scene.CHUNKS_PER_ROW_ON_THE_MAP; i++)
				{
					this.chunkPacks[i - 1] = this.chunkPacks[i];
				}
					
				this.chunkPacks[Scene.CHUNKS_PER_ROW_ON_THE_MAP - 1] = tmp;
			}
			else for (i = 0; i < Scene.CHUNKS_PER_ROW_ON_THE_MAP; i++)
			{	
				tmp = this.chunkPacks[i];
				
				if (change.y == 1) 
				{
					tmp.moveDown();
					tmp.chunks[Scene.MERGED_CHUNKS - 1].randomizeWords();
				}
				else if (change.y == -1)
				{
					tmp.moveUp();
					tmp.chunks[0].randomizeWords();
				}
			}
			
			this.xDChunks += change.x * Chunk.CELLS_PER_ROW;
			this.yDChunks += change.y * Chunk.CELLS_PER_ROW;
			
			this.dispatchUpdate(new Update("moveEverything", new DCellXY(change.x * Chunk.CELLS_PER_ROW, 
																		 change.y * Chunk.CELLS_PER_ROW)));
		}
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IScene, this);
		}
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.area = table.getInformer(IChoosenArea);
			
			
			CONFIG::debug
			if (Chunk.CELLS_PER_ROW * Scene.CHUNKS_PER_ROW_ON_THE_MAP != Metric.WIDTH ||
			    Chunk.CELLS_PER_ROW * Scene.CHUNKS_PER_ROW_ON_THE_MAP != Metric.HEIGHT)
				throw new Error("Badly compatible constant sets");
		}
	}

}