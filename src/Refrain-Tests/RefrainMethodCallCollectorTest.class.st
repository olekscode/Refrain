Class {
	#name : #RefrainMethodCallCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'methodChange'
	],
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #running }
RefrainMethodCallCollectorTest >> setUp [
	| method commit |
	super setUp.
	
	method := RefrainMethod new
		className: #RefrainTestsMockClass;
		selector: #mockSelect:;
		yourself.
		
	commit := RefrainCommit new
		sha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		message: 'Hello world';
		author: 'Oleksandr Zaitsev';
		tags: #('1.0.1');
		datetime: '10-12-2020' asDateAndTime;
		yourself.
	
	methodChange := RefrainMethodChange new
		method: method;
		commit: commit;
		oldSourceCode: (RefrainTestsMockClass >> #mockSelect:) sourceCode;
		newSourceCode: (RefrainTestsMockClass >> #mockNewSelect:) sourceCode;
		yourself.
]

{ #category : #tests }
RefrainMethodCallCollectorTest >> testExtractAddedAndDeletedMethodCallsFrom [
	| collector expectedDeletedMethodCalls expectedAddedMethodCalls |
	
	collector := RefrainMethodCallCollector new.
	collector extractAddedAndDeletedMethodCallsFrom: methodChange.
	
	expectedDeletedMethodCalls := { #ifTrue: } asSet
		collect: [ :selector |
			RefrainMethodCall new
				selector: selector;
				makeDeleted;
				yourself ].
			
	expectedAddedMethodCalls := { #ifFalse: . #not } asSet
		collect: [ :selector |
			RefrainMethodCall new
				selector: selector;
				makeAdded;
				yourself ].
			
	self assert: methodChange deletedMethodCalls equals: expectedDeletedMethodCalls.
	self assert: methodChange addedMethodCalls equals: expectedAddedMethodCalls.
	

]
