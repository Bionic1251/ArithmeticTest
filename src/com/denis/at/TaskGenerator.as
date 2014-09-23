package com.denis.at {

	public class TaskGenerator {
		private static const MAX_VALUE:int = 100;
		private static const MIN_VALUE:int = 20;
		private static const MAX_LITTLE_VALUE:int = 9;
		private static const MIN_LITTLE_VALUE:int = 2;

		public function TaskGenerator() {
		}

		public static function generateTask():QuestionInfo {
			var a:int = generateBigValue();
			var b:int = generateLittleValue();
			var c:int = generateLittleValue();
			var result:QuestionInfo;

			if (Math.random() < 0.5) {
				result = addition(a, b, c);
			} else {
				result = subtraction(a, b, c);
			}
			return result;
		}

		private static function addition(a:int, b:int, c:int):QuestionInfo {
			var result:QuestionInfo;
			if (Math.random() < 0.5) {
				result = addMultiplication(a, b, c);
			} else {
				result = addDivision(a, b, c)
			}
			return result;
		}

		private static function subtraction(a:int, b:int, c:int):QuestionInfo {
			var result:QuestionInfo;
			if (Math.random() < 0.5) {
				result = subMultiplication(a, b, c);
			} else {
				result = subDivision(a, b, c)
			}
			return result;
		}

		private static function subMultiplication(a:int, b:int,
				c:int):QuestionInfo {
			var result:QuestionInfo;
			if (a - b * c > 0) {
				result = getResult(a, '-', b, '*', c, a - b * c);
			} else {
				result = getResult(b, '*', c, '-', a, b * c - a);
			}
			return result;
		}

		private static function subDivision(a:int, b:int, c:int):QuestionInfo {
			var result:QuestionInfo;
			result = getResult(a, '-', b * c, '/', c, a - b);
			return result;
		}

		private static function addMultiplication(a:int, b:int,
				c:int):QuestionInfo {
			var result:QuestionInfo;
			if (a + b * c < MAX_VALUE) {
				result = getResult(a, '+', b, '*', c, a + b * c);
			} else {
				result = addDivision(a, b, c);
			}
			return result;
		}

		private static function addDivision(a:int, b:int, c:int):QuestionInfo {
			var result:QuestionInfo;
			if (a + b < MAX_VALUE) {
				result = getResult(a, '+', b * c, '/', c, a + b);
			} else {
				result = subMultiplication(a, b, c);
			}
			return result;
		}

		private static function getResult(... args):QuestionInfo {
			return new QuestionInfo(args[0] + " " + args[1] + " " + args[2] +
					" " + args[3] + " " +
					args[4],
					args[5]);
		}

		private static function generateBigValue():int {
			return Math.random() * (MAX_VALUE - MIN_VALUE) + MIN_VALUE - 1;
		}

		private static function generateLittleValue():int {
			return Math.random() * (MAX_LITTLE_VALUE - MIN_LITTLE_VALUE) +
					MIN_LITTLE_VALUE;
		}
	}
}