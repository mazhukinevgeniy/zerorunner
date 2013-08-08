package game.ui 
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.particles.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	
	public class PauseView
	{
		[Embed(source="../../../res/assets/particles/pause/particle.pex", mimeType="application/octet-stream")]
		private static const ParticleConfig:Class;
		
		[Embed(source="../../../res/assets/particles/pause/texture.png")]
		private static const Particle:Class;
		
		
		private var particles:PDParticleSystem;
		private var notification:TextField;
		
		private var container:Sprite;
		
		private var isGameOver:Boolean = true;
		
		public function PauseView(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.gameOver);
			flow.addUpdateListener(ZeroRunner.setPause);
			
			this.container = new Sprite();
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
			
			this.notification = new TextField(500, 40, "Game paused", "HiLo-Deco", 30);
			this.container.addChild(this.notification);
			
			this.notification.y += 50;
			
			var config:XML = new XML(new PauseView.ParticleConfig());
			var texture:Texture = Texture.fromBitmap(new PauseView.Particle());
			
			this.particles = new PDParticleSystem(config, texture);
			this.container.addChild(this.particles);
			Starling.juggler.add(this.particles);
		}
		
		update function gameOver():void
		{
			this.isGameOver = true;
		}
		
		update function setPause(value:Boolean):void
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
	}

}