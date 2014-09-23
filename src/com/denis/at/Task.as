package com.denis.at {
	[Bindable]
	public class Task {
		public var question:String;
		public var answer:int;
		public var userAnswer:int;

		public function Task(question:String, answer:int, userAnswer:int) {
			this.question = question;
			this.answer = answer;
			this.userAnswer = userAnswer;
		}
	}
}
