package Scene
{
	import Entities.MenuEvent;
	import Entities.MenuPopup;
	import Entities.SweeperTile;
	
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class GameplayScene extends Sprite
	{
		//Contains tile entities
		private var tiles:Array;
		
		//Contains 1/0 flags representing a mine
		private var tileState:Array;
		private var lost:Boolean = false;
		
		//Difficulty descriptors
		private var _columns:int = 10;
		private var _rows:int = 10;
		private var _mines:int = 0;
		private var _sweeps:int = 0;
		
		public function GameplayScene(width:int,height:int,count:int)
		{
			super();
			_columns = width;
			_rows = height;
			_mines = count;
			_sweeps = width * height;
			
		//	addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			tiles = new Array();
			tileState = new Array();
			//resource pool used to ensure an exact number of mines
			var spread:Array = [];
			for(var i:int = 0; i < width * height; i++){
				if(i < count){
					spread.push(1);
				}
				else{
					spread.push(0);
				}
			}
			for(var i:int = 0; i < _rows; i++){
				tiles.push(new Array());
				tileState.push(new Array());
				
				
				for(var j:int = 0; j < _columns; j++){
					tiles[i].push(new SweeperTile());
					tiles[i][j].y = 24 + (i * 48);
					tiles[i][j].x = 24 + (j * 48);
					
					addChild(tiles[i][j]);
					
					//Pulling values from the pool ensures we have exactly as many mines as we wanted.
					var randIndex:int = int(Math.random() * spread.length);
					tileState[i].push(spread[randIndex]);
					
					spread.splice(randIndex, 1);
					
					
				}
			}
			
			addEventListener(MouseEvent.CLICK, onClick);
			//Prints out a true false table for click verification
			for(var test:int = 0; test < 10; test++){
				trace(tileState[test]);
			}
			mouseChildren = false;
		}
		
		//Quick and dirty way to handle odd shaped and small screen sizes.
		/*
		
		
		NOTE:: I believe it would work, but since I don't have a device to test it on, its getting my actual screen size
				not the size of the device screen.  
		
		private function onAddedToStage(e:Event):void
		{
			
			
			var mainScreen:Screen = Screen.mainScreen;
			var screenBounds:Rectangle = mainScreen.bounds;
			
			trace(screenBounds.width, screenBounds.height,48 * _columns);
			
			if(screenBounds.width < 48 * _columns){
				scaleX = scaleY = screenBounds.width / (48 * _columns);
			}
			else if(screenBounds.height < 48 * _rows){
				scaleX = scaleY = screenBounds.height / (48 * _rows);
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}*/
		
		private function cleanup():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			
			
		}
		
		private var popup:MenuPopup;
		public function displayLosePopup():void
		{
			popup = new MenuPopup(_columns * _rows - _sweeps);
			popup.x = (stage.width/2) - (popup.width/2);
			popup.y = (stage.height/2) -(popup.height/2);
			
			
			
			stage.addChild(popup);
		//	cleanup();
			popup.okayButton.addEventListener(MouseEvent.CLICK, onYes);
			popup.cancelButton.addEventListener(MouseEvent.CLICK, onNo);
		}
		
		//As display lose popup, but with a more generous final score calculation
		public function displayWinPopup():void
		{
			popup = new MenuPopup(_columns * _rows);
			popup.x = (stage.width/2) - (popup.width/2);
			popup.y = (stage.height/2) -(popup.height/2);;
			stage.addChild(popup);
		//	cleanup();
			popup.okayButton.addEventListener(MouseEvent.CLICK, onYes);
			popup.cancelButton.addEventListener(MouseEvent.CLICK, onNo);
		}
		
		public function onNo(e:MouseEvent):void
		{
			trace("CLeek");
			popup.okayButton.removeEventListener(MouseEvent.CLICK, onYes);
			popup.cancelButton.removeEventListener(MouseEvent.CLICK, onNo);
			stage.removeChild(popup);
			cleanup();
			var event:MenuEvent = new MenuEvent(MenuEvent.RETURN_TO_MENU)
			dispatchEvent(event);
		}
		
		public function onYes(e:MouseEvent):void
		{
			trace("cleEk");
			popup.okayButton.removeEventListener(MouseEvent.CLICK, onYes);
			popup.cancelButton.removeEventListener(MouseEvent.CLICK, onNo);
			stage.removeChild(popup);
			cleanup();
			var event:MenuEvent = new MenuEvent(MenuEvent.BYPASS_MENU)
			event.width = _columns;
			event.height = _rows;
			event.mines = _mines;
			dispatchEvent(event);
		}
		
		
		//The main gameplay touch handler. 
		public function onClick(e:MouseEvent):void
		{
			trace("click");
			if(lost){
				return;
			}
			
			var xIndex:int = (e.localY - (24 * scaleX)) / (48 * scaleX);
			var yIndex:int = (e.localX - (24 * scaleY)) / (48 * scaleY);
			trace(e.localX, e.localY, xIndex, yIndex);
			if(xIndex > _columns || yIndex > _rows){
				return;
			}
			
			checkAndReveal(xIndex, yIndex);
			
		}
		
		//Brute force reveals every space on the board.  Called after the game is done with
		public function revealAll():void
		{
			for(var xIndex:int = 0; xIndex < _columns; xIndex++){
				for(var yIndex:int = 0; yIndex < _rows; yIndex++){
					if(tiles[xIndex][yIndex].reveal()){ continue;}
					
					var trueCount:int = 0
					for(var i:int = -1; i < 2; i++){
						for(var j:int = -1; j < 2; j++){
							//This line prevents wrapping
							if(xIndex + i < 0 || yIndex + j < 0 || xIndex + i > _columns - 1 || yIndex + j > _rows - 1){continue;}
							if(tileState[(xIndex + i) % _columns][(yIndex + j) % _rows] == 1){
								if(i == 0 && j == 0){
									trueCount = 10;
									
								}
								else{
									trueCount++;
								}
							}
						}
					}
					
					if(trueCount > 0){
						tiles[xIndex][yIndex].setNumber(trueCount);
					}
				}
			}
		}
		
		//Propogates throughout tiles as it encounters tiles that do not border a mine
		//Doesn't edge wrap.  Encountering a mine ends the game
		public function checkAndReveal(xIndex:int, yIndex:int):void{
			trace(xIndex, yIndex);
			if(xIndex >= _columns || yIndex >= _rows){return;}
			if(tiles[xIndex][yIndex].reveal()){ return;}
			_sweeps--;
			var trueCount:int = 0
			for(var i:int = -1; i < 2; i++){
				for(var j:int = -1; j < 2; j++){
					//This line prevents wrapping
					if(xIndex + i < 0 || yIndex + j < 0 || xIndex + i > _columns - 1 || yIndex + j > _rows - 1){continue;}
					if(tileState[(xIndex + i) % _columns][(yIndex + j) % _rows] == 1){
						if(i == 0 && j == 0){
							trueCount = 10;
							lost = true;
							revealAll();
							displayLosePopup();
						}
						else{
							trueCount++;
						}
					}
				}
			}
			
			if(trueCount > 0 && !lost){
				tiles[xIndex][yIndex].setNumber(trueCount);
			}
			else{
				if(lost){tiles[xIndex][yIndex].setNumber(trueCount);}
				for(var i:int = -1; i < 2; i++){
					for(var j:int = -1; j < 2; j++){
						//This line prevents wrapping
						if(xIndex + i < 0 || yIndex + j < 0 || xIndex + i > _columns - 1 || yIndex + j > _rows - 1){continue;}
						if(i != 0 || j != 0){
							checkAndReveal((xIndex + i) % _columns,(yIndex + j )% _rows);
						}
					}
				}
			}
			if(_sweeps <= _mines){
				cleanup();
				displayWinPopup();
			}
		}
		
	}
}