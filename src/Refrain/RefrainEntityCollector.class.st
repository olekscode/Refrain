Class {
	#name : #RefrainEntityCollector,
	#superclass : #Object,
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> collectEntitiesFromCode: aSourceCode usingVisitor: aVisitor [
	| ast |
	ast := RBParser parseMethod: aSourceCode.
	ast acceptVisitor: aVisitor.
	^ aVisitor collectedEntities
]

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> collectEntitiesFromNewCode: aSourceCode [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> collectEntitiesFromOldCode: aSourceCode [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RefrainEntityCollector >> extractAddedAndDeletedEntitiesFrom: aMethodChange [
	| oldEntities newEntities |
	
	oldEntities := self collectEntitiesFromOldCode: aMethodChange oldSourceCode.
	newEntities := self collectEntitiesFromNewCode: aMethodChange newSourceCode.
	
	aMethodChange addedEntities: (newEntities difference: oldEntities).
	aMethodChange deletedEntities: (oldEntities difference: newEntities).
	
	aMethodChange addedEntities do: [ :each | each makeAdded ].
	aMethodChange deletedEntities do: [ :each | each makeDeleted ].
	
]
