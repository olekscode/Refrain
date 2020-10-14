Class {
	#name : #RefrainMethodCall,
	#superclass : #RefrainEntity,
	#instVars : [
		'selector'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainMethodCall >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ super = anObject and: [
		anObject selector = selector ]
]

{ #category : #comparing }
RefrainMethodCall >> hash [ 
	^ super hash bitXor: selector hash
]

{ #category : #printing }
RefrainMethodCall >> printOn: aStream [
	aStream nextPutAll: selector.
]

{ #category : #accessing }
RefrainMethodCall >> selector [
	^ selector
]

{ #category : #accessing }
RefrainMethodCall >> selector: anObject [
	selector := anObject
]
