package Entities
{
	import Assets.AssetManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SweeperButton extends Sprite
	{
		private var facade:DisplayObject;
		public function SweeperButton(text:String)
		{
			super();
			
			facade = AssetManager.getBitmap("RevealedTile");
			facade.width = 128;
			addChild(facade);
			
		
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.align = TextFormatAlign.CENTER;
			txtFormat.bold = true;
			txtFormat.font = "Arial Black"
			
			var txtField:TextField = new TextField();
			txtField.defaultTextFormat = txtFormat;
			txtField.selectable = false;
			
			//txtField.textColor = (0x110000 * number) + (0x000011 * (9 - number));
			
			txtField.text = text;
			addChild(txtField);
			txtField.x = 0;
			txtField.y = 10;
		}
		
		
	}
}