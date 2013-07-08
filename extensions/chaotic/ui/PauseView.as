package chaotic.ui 
{
	import chaotic.informers.IGiveInformers;
	import chaotic.updates.IGameOverHandler;
	import chaotic.updates.IInformerGetter;
	import chaotic.updates.IPauser;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.Update;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.particles.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class PauseView implements IInformerGetter, IGameOverHandler, IPauser
	{
		[Embed(source="../../../res/assets/particles/pause/particle.pex", mimeType="application/octet-stream")]
		private static const ParticleConfig:Class;
		
		[Embed(source="../../../res/assets/particles/pause/texture.png")]
		private static const Particle:Class;
		
		
		private var particles:PDParticleSystem;
		private var notification:TextField;
		
		private var container:Sprite;
		
		private var isGameOver:Boolean = true;
		
		public function PauseView() 
		{
			this.container = new Sprite();
			
			this.notification = new TextField(500, 40, "Game paused", "HiLo-Deco", 30);
			this.container.addChild(this.notification);
			
			this.notification.y += 50;
			
			var config:XML = new XML(new PauseView.ParticleConfig());
			var texture:Texture = Texture.fromBitmap(new PauseView.Particle());
			
			this.particles = new PDParticleSystem(config, texture);
			this.container.addChild(this.particles);
			Starling.juggler.add(this.particles);
		}
		
		public function gameOver():void
		{
			this.isGameOver = true;
		}
		
		public function setPause(value:Boolean):void
		{
			if (!value)
			{
				this.isGameOver = false;
				this.particles.stop();
				this.notification.visible = false;
			}
			else if (!this.isGameOver)
			{
				this.notification.visible = true;
				this.particles.start();
			}
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			table.getInformer(IUpdateDispatcher).dispatchUpdate(new Update("addToTheHUD", this.container));
		}
	}

}