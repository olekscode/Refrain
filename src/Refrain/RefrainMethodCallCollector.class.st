Class {
	#name : #RefrainMethodCallCollector,
	#superclass : #Object,
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainMethodCallCollector >> collectMethodCallsFrom: aSourceCode [
	| ast visitor |
	ast := RBParser parseMethod: aSourceCode.
	
	visitor := RefrainMethodCallVisitor new.
	ast acceptVisitor: visitor.
	^ visitor methodCalls asSet
]

{ #category : #'as yet unclassified' }
RefrainMethodCallCollector >> extractAddedAndDeletedMethodCallsFrom: aMethodChange [
	| oldCalls newCalls |
	
	oldCalls := self collectMethodCallsFrom: aMethodChange oldSourceCode.
	newCalls := self collectMethodCallsFrom: aMethodChange newSourceCode.
	
	aMethodChange addedMethodCalls: (newCalls difference: oldCalls).
	aMethodChange deletedMethodCalls: (oldCalls difference: newCalls).
	
	aMethodChange addedMethodCalls do: [ :each | each makeAdded ].
	aMethodChange deletedMethodCalls do: [ :each | each makeDeleted ].
	
]
