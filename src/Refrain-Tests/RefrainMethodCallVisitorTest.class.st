Class {
	#name : #RefrainMethodCallVisitorTest,
	#superclass : #TestCase,
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainMethodCallVisitorTest >> testAcceptVisitor [
	| method visitor expectedMethodCalls |
	method := RefrainMethodsMock >> #mockOldSelect:.
	visitor := RefrainMethodCallVisitor new.
	
	method ast acceptVisitor: visitor.
	
	expectedMethodCalls := { #copyEmpty . #do: . #ifTrue: . #value: . #add: } asOrderedCollection
		collect: [ :selector |
			RefrainMethodCall new
				selector: selector;
				yourself ].
			
	self assert: visitor methodCalls equals: expectedMethodCalls.
]
