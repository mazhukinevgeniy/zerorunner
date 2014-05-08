		private var _status:StatusReporter;
		private var _preferences:Preferences;
		
		private var _fuel:IFuel;
		
		private var _items:Items;
		private var _scene:IScene;
		private var _projectiles:Projectiles;
		
		private var _inputT:InputTeller;
		private var _inputC:InputCollector;
		
		private var _gameMenu:IGameMenu;
		
		private var _projController:ProjectileController;
		
		
		public function GameElements(assets:AssetManager) 
		{
			this._projController = new ProjectileController();
			this._status = new StatusReporter(this._flow);
			this._preferences = new Preferences(this._flow);
			
			this._inputC = new InputCollector();
			this._inputT = new InputTeller(this._inputC);
			
			this._scene = new Scene(this);
			this._items = new Items(this, this._status);
			this._fuel = new FuelTracker(this);
			this._projectiles = new Projectiles(this);
			
			var time:Time = new Time(this);
			
			new GameUpdateConverter(this);
			
			
			this._projController.addSubscriber(this._projectiles);
		}
		
		public function get projectileController():ProjectileController { return this._projController; }
		
		public function get fuel():IFuel { return this._fuel; }
		public function get items():Items { return this._items; }
		public function get scene():IScene { return this._scene; }
		public function get status():IStatus { return this._status; }//TODO: something is wrong
		public function get inputTeller():InputTeller { return this._inputT; }
		public function get preferences():Preferences { return this._preferences; }
		public function get projectiles():IProjectiles { return this._projectiles; }
		public function get inputCollector():InputCollector { return this._inputC; }
		public function get displayRoot():DisplayObjectContainer { return this._root; }