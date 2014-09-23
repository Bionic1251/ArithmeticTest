package com.denis.at {
	public class Result {
		public var questionCount:int;
		public var rightAnsweredQuestionCount:int;

		public function Result(questionCount:int,
				rightAnsweredQuestionCount:int) {
			this.questionCount = questionCount;
			this.rightAnsweredQuestionCount = rightAnsweredQuestionCount;
		}
	}
}
