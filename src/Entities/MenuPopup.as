package Entities
{
	import Assets.AssetManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class MenuPopup extends Sprite
	{
		public var okayButton:SweeperButton;
		public var cancelButton:SweeperButton;
		private var facade:DisplayObject;
		
		public function MenuPopup(score:int)
		{
			super();
			
			mouseEnabled = false;
			facade = AssetManager.getBitmap("Tile");
			facade.width = 300;
			facade.height = 150;
			addChild(facade);
			
			facade.x = 75;
			facade.y = 20;
			
			var title:TextField = new TextField();
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = 24;
			txtFormat.align = TextFormatAlign.LEFT;
			txtFormat.bold = true;
			txtFormat.font = "Arial Black"
			
			title.defaultTextFormat = txtFormat;
			title.text = "Game Over";
			title.x = 150;
			title.y = 30;
			title.width = 300;
			
			var scoreLabel:TextField = new TextField();
			txtFormat.size = 14;
			scoreLabel.defaultTextFormat = txtFormat;
			scoreLabel.text = "Score: " + String(score);
			scoreLabel.x = 180;
			scoreLabel.y = 70
			scoreLabel.width = 300;
			addChild(scoreLabel);
			addChild(title);
			
			okayButton = new SweeperButton("Again");
			cancelButton = new SweeperButton("Main Menu");
			addChild(okayButton);
			addChild(cancelButton);
			okayButton.x = 150 - 65;
			okayButton.y = 110;
			cancelButton.x = 150 + 65;
			cancelButton.y = 110;
			
		//	addEventListener(MouseEvent.CLICK, onCatchClick);
		}
		
		//Was running into some click absorption issues.  Probably no longer necessary, since I moved the menu popup onto the stage.
		private function onCatchClick(e:MouseEvent):void
		{
			trace("CLEEK", e.localX, e.localY);
			
			if(Math.abs(e.localX - okayButton.x) < okayButton.width/2 && Math.abs(e.localY - okayButton.y) < okayButton.height/2){
				var event:MouseEvent = new MouseEvent(MouseEvent.CLICK,true,false,e.localX,e.localY,okayButton);
				//event.target = okayButton;
				dispatchEvent(event);
				//trace("dispatchuu");
			}
			else if(Math.abs(e.localX - cancelButton.x) < cancelButton.width/2 && Math.abs(e.localY - cancelButton.y) < cancelButton.height/2){
				var event:MouseEvent = new MouseEvent(MouseEvent.CLICK,true,false,e.localX,e.localY,cancelButton);
				//event.target = cancelButton;
				dispatchEvent(event);
				//trace("dispatchuu cancel");
			}
			
		}
	}
}
