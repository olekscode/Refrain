Class {
	#name : #RefrainMethodCall,
	#superclass : #Object,
	#instVars : [
		'selector',
		'isAdded'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainMethodCall >> < anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ selector < anObject selector
]

{ #category : #comparing }
RefrainMethodCall >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject selector = selector and: [
		anObject isAdded = isAdded ]
]

{ #category : #comparing }
RefrainMethodCall >> hash [ 
	^ selector hash bitXor: isAdded hash
]

{ #category : #accessing }
RefrainMethodCall >> isAdded [
	^ isAdded
]

{ #category : #accessing }
RefrainMethodCall >> isDeleted [
	^ isAdded not
]

{ #category : #accessing }
RefrainMethodCall >> makeAdded [
	isAdded := true
]

{ #category : #accessing }
RefrainMethodCall >> makeDeleted [
	isAdded := false
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
