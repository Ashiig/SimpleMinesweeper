package Entities
{
	import Assets.AssetManager;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SweeperTile extends Sprite
	{
		private var facade:Sprite;
		public function SweeperTile()
		{
			super();
			facade = new Sprite();
			facade.addChild(AssetManager.getBitmap("Tile"));
			addChild(facade);
			
		}
		
		private var __revealed:Boolean = false;
		public function reveal():Boolean
		{
			if(!__revealed){
			removeChild(facade);
			facade = new Sprite();
			facade.addChild(AssetManager.getBitmap("RevealedTile"));
			addChild(facade);
			__revealed = true;
			return false;
			}
			return true;
		}
		
		public function setNumber(number:int):void
		{
			if(number == 0){return;}
			if(number < 10){
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.align = TextFormatAlign.CENTER;
			txtFormat.bold = true;
			txtFormat.font = "Arial Black"
			
			var txtField:TextField = new TextField();
			txtField.defaultTextFormat = txtFormat;
			
			
			txtField.textColor = (0x110000 * number) + (0x000011 * (9 - number));
			
			txtField.text = String(number);
			addChild(txtField);
			txtField.x = -26;
			txtField.y = 14;
			}
			else{
				facade.addChild(AssetManager.getBitmap("Skull"));
			}
		}
		
	}
}