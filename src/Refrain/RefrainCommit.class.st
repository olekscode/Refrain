Class {
	#name : #RefrainCommit,
	#superclass : #Object,
	#instVars : [
		'sha',
		'date',
		'time',
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
				anObject date = date and: [
					anObject time = time and: [
						anObject author = author ] ] ] ] ]
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
RefrainCommit >> date [
	^ date
]

{ #category : #accessing }
RefrainCommit >> date: anObject [
	date := anObject
]

{ #category : #comparing }
RefrainCommit >> hash [
	| fields |
	fields := { sha . message . tags . date . time . author }.
	
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

{ #category : #accessing }
RefrainCommit >> time [
	^ time
]

{ #category : #accessing }
RefrainCommit >> time: anObject [
	time := anObject
]
