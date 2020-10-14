Class {
	#name : #RefrainSelectorVisitorTest,
	#superclass : #TestCase,
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainSelectorVisitorTest >> testAcceptVisitor [
	| method visitor expectedMethodCalls |
	method := RefrainMethodsMock >> #mockOldSelect:.
	visitor := RefrainSelectorVisitor new.
	
	method ast acceptVisitor: visitor.
	
	expectedMethodCalls := { #copyEmpty . #do: . #ifTrue: . #value: . #add: } asSet
		collect: [ :selector |
			RefrainSelectorEntity new
				selector: selector;
				yourself ].
			
	self assert: visitor collectedEntities equals: expectedMethodCalls.
]
