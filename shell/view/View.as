//this.addChild(this.background = new Background());			

this.addChild(new ButtonGlobalNavigation(30, "Play"));

this.addChild(this.game = new Sprite());
this.game.addChild(this.gameView = new Sprite());
this.game.addChild(this.panel = new Panel());
this.game.visible = false;

this.addChild(this.windows[0] = new MainMenu(this.assets));