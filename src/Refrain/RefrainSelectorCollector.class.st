Class {
	#name : #RefrainSelectorCollector,
	#superclass : #RefrainEntityCollector,
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainSelectorCollector >> collectEntitiesFromNewCode: aSourceCode [
	^ self
		collectEntitiesFromCode: aSourceCode
		usingVisitor: RefrainSelectorVisitor new.
]

{ #category : #'as yet unclassified' }
RefrainSelectorCollector >> collectEntitiesFromOldCode: aSourceCode [
	^ self
		collectEntitiesFromCode: aSourceCode
		usingVisitor: RefrainSelectorVisitor new.
]
