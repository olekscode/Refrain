Class {
	#name : #RefrainProject,
	#superclass : #Object,
	#instVars : [
		'repository',
		'commitDictionary'
	],
	#category : #'Refrain-Models'
}

{ #category : #accessing }
RefrainProject >> commitDictionary [
	^ commitDictionary
]

{ #category : #initialization }
RefrainProject >> initialize [
	super initialize.
	commitDictionary := Dictionary new.
]

{ #category : #accessing }
RefrainProject >> repository [
	^ repository
]

{ #category : #accessing }
RefrainProject >> repository: anObject [
	repository := anObject
]
