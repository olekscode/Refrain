Class {
	#name : #RefrainEntity,
	#superclass : #Object,
	#instVars : [
		'isAdded'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainEntity >> < anObject [
	"TODO: Fix APriori and remove this"
	^ self hash < anObject hash
]

{ #category : #comparing }
RefrainEntity >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject isAdded = isAdded
]

{ #category : #comparing }
RefrainEntity >> hash [ 
	^ isAdded hash
]

{ #category : #accessing }
RefrainEntity >> isAdded [
	^ isAdded
]

{ #category : #testing }
RefrainEntity >> isDeleted [
	^ isAdded not
]

{ #category : #accessing }
RefrainEntity >> makeAdded [
	isAdded := true
]

{ #category : #accessing }
RefrainEntity >> makeDeleted [
	isAdded := false
]
