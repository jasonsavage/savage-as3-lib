package
{
	import com.greensock.TweenLite;
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.GradientFillStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.LinearLayout;
	import com.savage.model.data.StringBuffer;
	import com.savage.utils.LayoutUtil;
	import com.savage.views.ButtonView;
	import com.savage.views.ImageView;
	import com.savage.views.ScrollPane;
	import com.savage.views.SliderView;
	import com.savage.views.TextView;
	import com.savage.views.View;
	import com.savage.views.menu.AccordionMenu;
	import com.savage.views.menu.AccordionMenuTab;
	import com.savage.views.scroll.ScrollBarView;
	import com.savage.views.video.ui.ContractButton;
	import com.savage.views.video.ui.ExpandButton;
	import com.savage.views.video.ui.MuteButton;
	import com.savage.views.video.ui.PauseButton;
	import com.savage.views.video.ui.PlayButton;
	import com.savage.views.video.ui.SpeakerButton;
	import com.savage.views.video.ui.SpeakerVolumeBars;
	import com.savage.views.video.ui.VolumeContol;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.osmf.layout.HorizontalAlign;
	
	[SWF(width="640",height="480", frameRate="30")]
	
	/**
	 * The savage_lib_tester class ...
	 * @author jason.s
	 */
	public class savage_lib_tester extends Sprite
	{
		[Embed(source="../embedded/Chrysanthemum.jpg")]
		private var FlowerPict:Class;
		
		/**
		 * Constructor
		 */
		public function savage_lib_tester()
		{
			super();
			
			//var view:View = new View();
			//view.layout = new LinearLayout(LinearLayout.VERTICAL, 10);
			//view.layout.setPadding(20, 10, 20, 10);
			//view.background = new GradientFillStyle("linear", [0xffffff,0x58a9ee]);
			//addChild(view);
			
			var rect:RectangleShape = new RectangleShape(200, 30, 0);
			var rect2:RectangleShape = new RectangleShape(200, 30, 0x333333);
			var rect3:RectangleShape = new RectangleShape(200, 30, 0x666666);
			////btn.background = new GradientFillStyle("linear", [0xffffff,0x58a9ee]);
			//btn.cornerRadius = 5;
			
			//view.addChild( rect );
			//view.addChild( rect2 );
			//view.addChild( rect3 );
			
			//view.addChild( new ExpandButton() );
			//view.addChild( new MuteButton() );
			///view.addChild( new PauseButton() );
			//view.addChild( new PlayButton() );
			//view.addChild( new SpeakerButton() );
			//view.addChild( new SliderView() );
			
			/*
			var menu:AccordionMenu = new AccordionMenu();
			menu.layout.setSize(640, 480);
			addChild(menu);
			
			menu.addTab(new AccordionMenuTab());
			menu.addTab(new AccordionMenuTab());
			menu.addTab(new AccordionMenuTab());
			menu.addTab(new AccordionMenuTab());
			menu.addTab(new AccordionMenuTab());
			menu.addTab(new AccordionMenuTab());
			*/
			
			/*
			var btn:ButtonView = new ButtonView();
			btn.upStateView = new RectangleShape(200, 30, 0);
			btn.overStateView = new RectangleShape(200, 30, 0x0000ff); //blue
			btn.downStateView = new RectangleShape(200, 30, 0xff0000); //red
			addChild(btn);
			
			
			btn.overStateView = new RectangleShape(200, 30, 0x00ff00);
			*/
			
			/*
			var tv:TextView = new TextView();
			tv.layout.setSize(500, 20);
			tv.layout.setPadding(10,5,10,5);
			tv.background = new SolidFillStyle(0x0000ff, 0.5);
			tv.fontFamily = "Verdana";
			//tv.bold = true;
			tv.color = 0x000000;
			tv.embedFonts = false;
			
			tv.htmlText = "<b>Hello World</b>";
			
			addChild(tv);
			
			tv.textField.background = true;
			*/
			
			
		}
	}
}