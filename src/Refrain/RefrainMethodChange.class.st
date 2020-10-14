Class {
	#name : #RefrainMethodChange,
	#superclass : #Object,
	#instVars : [
		'method',
		'commit',
		'oldSourceCode',
		'newSourceCode',
		'addedMethodCalls',
		'deletedMethodCalls'
	],
	#category : #'Refrain-Models'
}

{ #category : #comparing }
RefrainMethodChange >> = anObject [
	anObject class = self class
		ifFalse: [ ^ false ].
		
	^ anObject method = method and: [ 
		anObject commit = commit and: [ 
			anObject oldSourceCode = oldSourceCode and: [ 
				anObject newSourceCode = newSourceCode and: [ 
					anObject addedMethodCalls = addedMethodCalls and: [ 
						anObject deletedMethodCalls = deletedMethodCalls ] ] ] ] ]
]

{ #category : #accessing }
RefrainMethodChange >> addedMethodCalls [
	^ addedMethodCalls
]

{ #category : #accessing }
RefrainMethodChange >> addedMethodCalls: anObject [
	addedMethodCalls := anObject
]

{ #category : #accessing }
RefrainMethodChange >> commit [
	^ commit
]

{ #category : #accessing }
RefrainMethodChange >> commit: anObject [
	commit := anObject
]

{ #category : #accessing }
RefrainMethodChange >> deletedMethodCalls [
	^ deletedMethodCalls
]

{ #category : #accessing }
RefrainMethodChange >> deletedMethodCalls: anObject [
	deletedMethodCalls := anObject
]

{ #category : #comparing }
RefrainMethodChange >> hash [
	| fields |
	fields := { method . commit . oldSourceCode . newSourceCode . addedMethodCalls . deletedMethodCalls }.
	
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
