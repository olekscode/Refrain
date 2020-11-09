Class {
	#name : #RefrainMethodChange,
	#superclass : #Object,
	#instVars : [
		'method',
		'commitSha',
		'oldSourceCode',
		'newSourceCode',
		'addedEntities',
		'deletedEntities'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainMethodChange >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject method = method and: [ 
		anObject commitSha = commitSha and: [ 
			anObject oldSourceCode = oldSourceCode and: [ 
				anObject newSourceCode = newSourceCode and: [ 
					anObject addedEntities = addedEntities and: [ 
						anObject deletedEntities = deletedEntities ] ] ] ] ]
]

{ #category : #accessing }
RefrainMethodChange >> addedEntities [
	^ addedEntities
]

{ #category : #accessing }
RefrainMethodChange >> addedEntities: anObject [
	addedEntities := anObject
]

{ #category : #accessing }
RefrainMethodChange >> commitSha [
	^ commitSha
]

{ #category : #accessing }
RefrainMethodChange >> commitSha: anObject [
	commitSha := anObject
]

{ #category : #accessing }
RefrainMethodChange >> deletedEntities [
	^ deletedEntities
]

{ #category : #accessing }
RefrainMethodChange >> deletedEntities: anObject [
	deletedEntities := anObject
]

{ #category : #comparing }
RefrainMethodChange >> hash [
	| fields |
	fields := { method . commitSha . oldSourceCode . newSourceCode . addedEntities . deletedEntities }.
	
	^ fields inject: self class hash into: [ :sum :each |
		sum bitXor: each hash ]
]

{ #category : #accessing }
RefrainMethodChange >> method [
	^ method
]

{ #category : #accessing }
RefrainMethodChange >> method: anObject [
	method := anObject
]

{ #category : #accessing }
RefrainMethodChange >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
RefrainMethodChange >> newSourceCode: anObject [
	newSourceCode := anObject
]

{ #category : #accessing }
RefrainMethodChange >> oldSourceCode [
	^ oldSourceCode
]

{ #category : #accessing }
RefrainMethodChange >> oldSourceCode: anObject [
	oldSourceCode := anObject
]
