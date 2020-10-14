Class {
	#name : #RefrainEntityCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'methodChange'
	],
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #running }
RefrainEntityCollectorTest >> setUp [
	| method commit |
	super setUp.
	
	method := RefrainMethod new
		className: #RefrainTestsMockClass;
		selector: #mockOldSelect:;
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
		oldSourceCode: (RefrainMethodsMock >> #mockOldSelect:) sourceCode;
		newSourceCode: (RefrainMethodsMock >> #mockNewSelect:) sourceCode;
		yourself.
]

{ #category : #tests }
RefrainEntityCollectorTest >> testExtractAddedAndDeletedEntitiesFrom [
	| collector expectedDeletedMethodCalls expectedAddedMethodCalls |
	
	collector := RefrainEntityCollector usingVisitorClass: RefrainSelectorVisitor.
	collector extractAddedAndDeletedEntitiesFrom: methodChange.
	
	expectedDeletedMethodCalls := { #ifTrue: } asSet
		collect: [ :selector |
			RefrainSelectorEntity new
				selector: selector;
				makeDeleted;
				yourself ].
			
	expectedAddedMethodCalls := { #ifFalse: . #not } asSet
		collect: [ :selector |
			RefrainSelectorEntity new
				selector: selector;
				makeAdded;
				yourself ].
			
	self assert: methodChange deletedEntities equals: expectedDeletedMethodCalls.
	self assert: methodChange addedEntities equals: expectedAddedMethodCalls.
	

]