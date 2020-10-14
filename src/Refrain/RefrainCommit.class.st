Class {
	#name : #RefrainCommit,
	#superclass : #Object,
	#instVars : [
		'sha',
		'datetime',
		'message',
		'tags',
		'author'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainCommit >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject sha = sha and: [ 
		anObject message = message and: [ 
			anObject tags = tags and: [ 
				anObject datetime = datetime and: [ 
					anObject author = author ] ] ] ]
]

{ #category : #accessing }
RefrainCommit >> author [
	^ author
]

{ #category : #accessing }
RefrainCommit >> author: anObject [
	author := anObject
]

{ #category : #accessing }
RefrainCommit >> datetime [
	^ datetime
]

{ #category : #accessing }
RefrainCommit >> datetime: anObject [
	datetime := anObject
]

{ #category : #comparing }
RefrainCommit >> hash [
	| fields |
	fields := { sha . message . tags . datetime . author }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #initialization }
RefrainCommit >> initialize [
	super initialize.
	tags := OrderedCollection new.
]

{ #category : #accessing }
RefrainCommit >> message [
	^ message
]

{ #category : #accessing }
RefrainCommit >> message: anObject [
	message := anObject
]

{ #category : #printing }
RefrainCommit >> printOn: aStream [
	aStream nextPutAll: sha
]

{ #category : #accessing }
RefrainCommit >> sha [
	^ sha
]

{ #category : #accessing }
RefrainCommit >> sha: anObject [
	sha := anObject
]

{ #category : #'as yet unclassified' }
RefrainCommit >> shortSha [
	^ sha copyFrom: 1 to: 7
]

{ #category : #accessing }
RefrainCommit >> tags [
	^ tags
]

{ #category : #accessing }
RefrainCommit >> tags: anObject [
	tags := anObject
]
