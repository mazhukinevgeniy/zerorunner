package events 
{
	
	public class GlobalEvent 
	{
		
		public static const ACTIVATED:String = "activated"; //not used yet
		public static const DEACTIVATED:String = "deactivated";
		
		public static const PROJECTILE_FELL:String = "projectile_fell";
		
		public static const MAP_FRAME:String = "map_frame";
		public static const GAME_FRAME:String = "game_frame";
		
		public static const ACTIVATE_GAME_SCREEN:String = "activate_game_screen";
		public static const SCREEN_ACTIVATED:String = "screen_activated";
		//TODO: do we need two events for that?
		
		public static const NEW_GAME:String = "new_game";
		public static const QUIT_GAME:String = "quit_game";
		
		public static const GAME_STOPPED:String = "game_stopped";
		
		public static const COLLECTIBLE_FOUND:String = "collectible_found";
		
		public static const SET_SOUND_VOLUME:String = "set_sound_volume";
		public static const SET_SOUND_MUTE:String = "set_sound_mute";
		
		public static const ADD_INPUT_PIECE:String = "add_input_piece";
		public static const PERFORM_ACTION:String = "perform_action";
		
		public function GlobalEvent() 
		{
			throw new Error("do not call");
		}
		
	}

}