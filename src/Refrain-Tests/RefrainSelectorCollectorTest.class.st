Class {
	#name : #RefrainSelectorCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'methodChange'
	],
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #running }
RefrainSelectorCollectorTest >> setUp [
	| method |
	super setUp.
	
	method := RefrainMethod new
		className: #RefrainTestsMockClass;
		selector: #mockOldSelect:;
		yourself.
	
	methodChange := RefrainMethodChange new
		method: method;
		commitSha: '14164de82d938df2cc98186fa0225a49fe7c98e0';
		oldSourceCode: (RefrainMethodsMock >> #mockOldSelect:) sourceCode;
		newSourceCode: (RefrainMethodsMock >> #mockNewSelect:) sourceCode;
		yourself.
]

{ #category : #tests }
RefrainSelectorCollectorTest >> testExtractAddedAndDeletedEntitiesFrom [
	| collector expectedDeletedMethodCalls expectedAddedMethodCalls |
	
	collector := RefrainSelectorCollector new.
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
