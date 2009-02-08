package com.j_nid.components {
	
	import com.j_nid.models.Person;	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.ComboBox;
	import mx.rpc.events.ResultEvent;

	public class SearchPersonBox extends ComboBox {
		
		private var people:ArrayCollection = new ArrayCollection();
		private var _typedText:String;
		private var timer:Timer = new Timer(500, 1);
		
		public function SearchPersonBox() {
			super();
			setStyle("arrowButtonWidth", 0);
			addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			labelField = "name";
			editable = true;
		}
		
		public function addPerson(obj:Person):void {
			people.addItem(obj);
		}
		
		public function get person():Person {
			for each (var person:Person in people) {
				if (person.name == text) {
					return person;
				}
			}
			return null;
		}
		
		private function keyUpListener(e:KeyboardEvent):void {
			if (textInput.text) {
				if (textInput.text != _typedText && e.keyCode != Keyboard.UP && e.keyCode != Keyboard.DOWN) {
					_typedText = textInput.text;
					timer.stop();
					timer = new Timer(500, 1);
					timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
						filter();
					});
					timer.start();
				}
			} else {
				_typedText = "";
				dataProvider = null;
				close();
			}
		}
		
		private function filter():void {
			dataProvider = people;
			ArrayCollection(dataProvider).filterFunction = function(item:Object):Boolean {
				var person:Person = Person(item);
				person.sortIndex = person.name.indexOf(_typedText);
				return person.sortIndex != -1;
			};
			var sort:Sort = new Sort();
			sort.fields = [new SortField("sortIndex")];
			ArrayCollection(dataProvider).sort = sort;
			ArrayCollection(dataProvider).refresh();
			selectedIndex = -1;
			textInput.text = "";
			open();
			textInput.text = _typedText;
			textInput.setSelection(_typedText.length, _typedText.length);
		}
	}
}