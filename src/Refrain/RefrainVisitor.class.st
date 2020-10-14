Class {
	#name : #RefrainVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'collectedEntities'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #accessing }
RefrainVisitor >> collectedEntities [
	^ collectedEntities
]

{ #category : #initialization }
RefrainVisitor >> initialize [ 
	super initialize.
	collectedEntities := Set new.
]
