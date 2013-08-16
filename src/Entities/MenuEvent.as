package Entities
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const HARD:String = "HARD_MODE_ENGAGED";
		public static const MEDIUM:String = "NORMAL_MODE_ENGAGED";
		public static const EASY:String = "WUSS_MODE_ENGAGED";
		
		public static const RETURN_TO_MENU:String = "WIN_OR_LOSE_IT_ALL_COMES_BACK_TO_WANKERSHIM";
		public static const BYPASS_MENU:String = "GET_BACK_IN_THE_MIX";
		
		public var width:int = 0;
		public var height:int = 0;
		public var mines:int = 0;
		
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}