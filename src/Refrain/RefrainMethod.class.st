Class {
	#name : #RefrainMethod,
	#superclass : #Object,
	#instVars : [
		'className',
		'selector'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainMethod >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject className = className and: [ 
		anObject selector = selector ]
]

{ #category : #accessing }
RefrainMethod >> className [
	^ className
]

{ #category : #accessing }
RefrainMethod >> className: anObject [
	className := anObject
]

{ #category : #comparing }
RefrainMethod >> hash [
	^ className hash bitXor: selector hash
]

{ #category : #printing }
RefrainMethod >> printOn: aStream [
	aStream
		nextPutAll: className;
		nextPutAll: '>>';
		nextPutAll: selector.
]

{ #category : #accessing }
RefrainMethod >> selector [
	^ selector
]

{ #category : #accessing }
RefrainMethod >> selector: anObject [
	selector := anObject
]
