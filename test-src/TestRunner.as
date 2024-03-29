﻿package 
{
	import flash.display.MovieClip;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import tests.TestClass;

	public class TestRunner extends MovieClip
	{
		public var traceListener:TraceListener;
		public var flexUnitCore:FlexUnitCore;

		public function TestRunner()
		{
			setUpTests();
			runTests();
			// To run your unit tests, set your .fla's document class to 'TestRunner.as'
		}

		private function setUpTests() : void
		{
			traceListener = new TraceListener();
			flexUnitCore = new FlexUnitCore();
			flexUnitCore.addListener(traceListener);
		}

		public function runTests():void
		{
			flexUnitCore.run(TestClass);
		}
	}

}
