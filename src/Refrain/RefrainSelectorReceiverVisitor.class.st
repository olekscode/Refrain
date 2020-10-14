Class {
	#name : #RefrainSelectorReceiverVisitor,
	#superclass : #RefrainVisitor,
	#category : #'Refrain-Controllers'
}

{ #category : #visiting }
RefrainSelectorReceiverVisitor >> visitMessageNode: aNode [
	| methodCall |
	
	methodCall := RefrainSelectorReceiverEntity new
		selector: aNode selector;
		receiver: aNode receiver sourceCode;
		yourself.
		
	collectedEntities add: methodCall.
	super visitMessageNode: aNode.
]
