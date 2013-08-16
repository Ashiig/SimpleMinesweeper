package Scene
{
	import Entities.MenuEvent;
	import Entities.SweeperButton;
	import Entities.SweeperTile;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class MenuScene extends Sprite
	{
		public function MenuScene()
		{
			super();
			
			var title:TextField = new TextField;
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = 24;
			txtFormat.align = TextFormatAlign.CENTER;
			txtFormat.bold = true;
			txtFormat.font = "Arial Black"
			
			title.defaultTextFormat = txtFormat;
			title.text = "Mein Shweeper";
			title.x = 120;
			title.y = 30;
			title.width = 300;
			addChild(title);
			
			var easy:SweeperButton = new SweeperButton("Play [Easy]");
			var medium:SweeperButton = new SweeperButton("Play [Med]")
			var hard:SweeperButton = new SweeperButton("Play [Hard]");
			addChild(easy);
			addChild(medium);
			addChild(hard);
			
			easy.addEventListener(MouseEvent.CLICK, onEasy);
			medium.addEventListener(MouseEvent.CLICK, onMedium);
			hard.addEventListener(MouseEvent.CLICK, onHard);
			
			easy.x = 60;
			easy.y = 100;
			
			medium.x = 60;
			medium.y = 150;
			
			hard.x = 60;
			hard.y = 200;
		}
		
		private function onEasy(e:MouseEvent):void
		{
			dispatchEvent(new MenuEvent(MenuEvent.EASY));
		}
		
		private function onMedium(e:MouseEvent):void
		{
			dispatchEvent(new MenuEvent(MenuEvent.MEDIUM));
		}
		
		private function onHard(e:MouseEvent):void
		{
			dispatchEvent(new MenuEvent(MenuEvent.HARD));
		}
	}
	
	
}