Class {
	#name : #RefrainSelectorEntity,
	#superclass : #RefrainEntity,
	#instVars : [
		'selector'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainSelectorEntity >> = anObject [
	^ super = anObject and: [
		anObject selector = selector ]
]

{ #category : #comparing }
RefrainSelectorEntity >> hash [ 
	^ super hash bitXor: selector hash
]

{ #category : #printing }
RefrainSelectorEntity >> printOn: aStream [
	aStream nextPutAll: selector.
]

{ #category : #accessing }
RefrainSelectorEntity >> selector [
	^ selector
]

{ #category : #accessing }
RefrainSelectorEntity >> selector: anObject [
	selector := anObject
]
