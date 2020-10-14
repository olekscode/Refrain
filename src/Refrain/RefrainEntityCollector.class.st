Class {
	#name : #RefrainEntityCollector,
	#superclass : #Object,
	#instVars : [
		'visitorClass'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainEntityCollector class >> usingVisitorClass: aVisitorClass [
	^ self new visitorClass: aVisitorClass; yourself
]

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> collectEntitiesFrom: aSourceCode [
	| ast visitor |
	ast := RBParser parseMethod: aSourceCode.
	visitor := visitorClass new.
	
	ast acceptVisitor: visitor.
	^ visitor collectedEntities
]

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> extractAddedAndDeletedEntitiesFrom: aMethodChange [
	| oldEntities newEntities |
	
	oldEntities := self collectEntitiesFrom: aMethodChange oldSourceCode.
	newEntities := self collectEntitiesFrom: aMethodChange newSourceCode.
	
	aMethodChange addedEntities: (newEntities difference: oldEntities).
	aMethodChange deletedEntities: (oldEntities difference: newEntities).
	
	aMethodChange addedEntities do: [ :each | each makeAdded ].
	aMethodChange deletedEntities do: [ :each | each makeDeleted ].
	
]

{ #category : #accessing }
RefrainEntityCollector >> visitorClass: aRefrainEntityVisitor [
	visitorClass := aRefrainEntityVisitor
]
