package com.denis.at {
	import flash.events.Event;

	public class FinishEvent extends Event {
		public static const FINISH:String = "finish";

		private var _questionCount:int;
		private var _rightAnswerCount:int;

		public function FinishEvent(type:String, questionCount:int,
				rightAnswerCount:int) {
			super(type, true);
			_questionCount = questionCount;
			_rightAnswerCount = rightAnswerCount;
		}

		override public function clone():Event {
			return new FinishEvent(type, _questionCount, _rightAnswerCount);
		}

		public function get questionCount():int {
			return _questionCount;
		}

		public function get rightAnswerCount():int {
			return _rightAnswerCount;
		}
	}
}