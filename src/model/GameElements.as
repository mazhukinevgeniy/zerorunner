
			
			this._inputC = new InputCollector();
			this._inputT = new InputTeller(this._inputC);
			
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