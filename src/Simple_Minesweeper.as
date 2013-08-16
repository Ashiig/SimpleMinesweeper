package
{
	import Assets.AssetManager;
	
	import Entities.MenuEvent;
	import Entities.SweeperTile;
	
	import Scene.GameplayScene;
	import Scene.MenuScene;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Simple_Minesweeper extends Sprite
	{
		
		private var currentScene:Sprite;
		
		public function Simple_Minesweeper()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		public function onAddedToStage(e:Event):void
		{
			trace("AND HERE WE GO");
			currentScene = new MenuScene();
			
			addChild(currentScene);
			
			currentScene.addEventListener(MenuEvent.EASY, onEasy);
			currentScene.addEventListener(MenuEvent.MEDIUM, onMedium);
			currentScene.addEventListener(MenuEvent.HARD, onHard);
			//addChild(AssetManager.getBitmap("Close"));
		}
		
		public function onEasy(e:MenuEvent):void
		{
			currentScene.removeEventListener(MenuEvent.EASY, onEasy);
			currentScene.removeEventListener(MenuEvent.MEDIUM, onMedium);
			currentScene.removeEventListener(MenuEvent.HARD, onHard);
			
			removeChild(currentScene);
			
			currentScene = new GameplayScene(8,8,8);
			currentScene.addEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.addEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			addChild(currentScene);
		}
		
		public function onMedium(e:MenuEvent):void
		{
			currentScene.removeEventListener(MenuEvent.EASY, onEasy);
			currentScene.removeEventListener(MenuEvent.MEDIUM, onMedium);
			currentScene.removeEventListener(MenuEvent.HARD, onHard);
			
			removeChild(currentScene);
			
			currentScene = new GameplayScene(10,10,16);
			currentScene.addEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.addEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			addChild(currentScene);
		}
		
		public function onHard(e:MenuEvent):void
		{
			currentScene.removeEventListener(MenuEvent.EASY, onEasy);
			currentScene.removeEventListener(MenuEvent.MEDIUM, onMedium);
			currentScene.removeEventListener(MenuEvent.HARD, onHard);
			
			removeChild(currentScene);
			
			currentScene = new GameplayScene(10,10,24);
			currentScene.addEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.addEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			addChild(currentScene);
		}
		
		public function returnToMenu(e:MenuEvent):void{
			trace("AND HERE WE GO222");
			currentScene.removeEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.removeEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			removeChild(currentScene);
			
			currentScene = new MenuScene();
			
			addChild(currentScene);
			
			currentScene.addEventListener(MenuEvent.EASY, onEasy);
			currentScene.addEventListener(MenuEvent.MEDIUM, onMedium);
			currentScene.addEventListener(MenuEvent.HARD, onHard);
		}
		
		public function replayGame(e:MenuEvent):void{
			trace("AND HERE WE GO");
			currentScene.removeEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.removeEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			removeChild(currentScene);
			
			currentScene = new GameplayScene(e.width,e.height,e.mines);
			currentScene.addEventListener(MenuEvent.RETURN_TO_MENU, returnToMenu);
			currentScene.addEventListener(MenuEvent.BYPASS_MENU, replayGame);
			
			addChild(currentScene);
		}
	}
}