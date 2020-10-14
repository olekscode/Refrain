Class {
	#name : #RefrainSelectorReceiverEntity,
	#superclass : #RefrainSelectorEntity,
	#instVars : [
		'receiver'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainSelectorReceiverEntity >> = anObject [
	^ super = anObject and: [
		anObject receiver = receiver ]
]

{ #category : #comparing }
RefrainSelectorReceiverEntity >> hash [ 
	^ super hash bitXor: receiver hash
]

{ #category : #printing }
RefrainSelectorReceiverEntity >> printOn: aStream [
	aStream
		nextPutAll: receiver asString;
		space;
		nextPutAll: selector.
]

{ #category : #accessing }
RefrainSelectorReceiverEntity >> receiver [
	^ receiver
]

{ #category : #accessing }
RefrainSelectorReceiverEntity >> receiver: anObject [
	receiver := anObject
]
