Class {
	#name : #RefrainProject,
	#superclass : #Object,
	#instVars : [
		'repository',
		'commits',
		'iceCommits'
	],
	#category : #'Refrain-Models'
}

{ #category : #accessing }
RefrainProject >> commits [
	^ commits
]

{ #category : #accessing }
RefrainProject >> iceCommits [
	^ iceCommits
]

{ #category : #initialization }
RefrainProject >> initialize [
	super initialize.
	commits := Dictionary new.
	iceCommits := Dictionary new.
]

{ #category : #accessing }
RefrainProject >> repository [
	^ repository
]

{ #category : #accessing }
RefrainProject >> repository: anObject [
	repository := anObject
]
