Class {
	#name : #RefrainSelectorVisitor,
	#superclass : #RefrainVisitor,
	#category : #'Refrain-Controllers'
}

{ #category : #visiting }
RefrainSelectorVisitor >> visitMessageNode: aNode [
	| methodCall |
	
	methodCall := RefrainSelectorEntity new
		selector: aNode selector;
		yourself.
		
	collectedEntities add: methodCall.
	super visitMessageNode: aNode.
]
