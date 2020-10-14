Class {
	#name : #RefrainMethodCallVisitor,
	#superclass : #RefrainVisitor,
	#category : #'Refrain-Controllers'
}

{ #category : #visiting }
RefrainMethodCallVisitor >> visitMessageNode: aNode [
	| methodCall |
	
	methodCall := RefrainMethodCall new
		selector: aNode selector;
		yourself.
		
	collectedEntities add: methodCall.
	super visitMessageNode: aNode.
]
