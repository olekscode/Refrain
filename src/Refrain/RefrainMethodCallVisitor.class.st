Class {
	#name : #RefrainMethodCallVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'methodCalls'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #initialization }
RefrainMethodCallVisitor >> initialize [ 
	super initialize.
	methodCalls := OrderedCollection new.
]

{ #category : #accessing }
RefrainMethodCallVisitor >> methodCalls [
	^ methodCalls
]

{ #category : #visiting }
RefrainMethodCallVisitor >> visitMessageNode: aNode [
	| methodCall |
	
	methodCall := RefrainMethodCall new
		selector: aNode selector;
		yourself.
		
	methodCalls add: methodCall.
	super visitMessageNode: aNode.
]
