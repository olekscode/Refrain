Class {
	#name : #Refrain,
	#superclass : #Object,
	#instVars : [
		'firstCommit',
		'lastCommit',
		'minNumberOfRepetitions',
		'maxNumberOfEntities',
		'methodChanges',
		'relevantMethodChanges',
		'methodChangeCollector',
		'entityCollector',
		'rules'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
Refrain class >> defaultEntityCollectorClass [
	^ RefrainSelectorCollector
]

{ #category : #'as yet unclassified' }
Refrain class >> defaultMaxNumberOfEntities [
	^ 4
]

{ #category : #'as yet unclassified' }
Refrain class >> repository: aRepository firstCommit: aFirstCommit lastCommit: aLastCommit [
	^ self new
		repository: aRepository;
		firstCommit: aFirstCommit;
		lastCommit: aLastCommit;
		yourself.
]

{ #category : #'as yet unclassified' }
Refrain class >> repositoryName: aRepositoryName firstCommit: aFirstCommit lastCommit: aLastCommit [
	^ self new
		repositoryName: aRepositoryName;
		firstCommit: aFirstCommit;
		lastCommit: aLastCommit;
		yourself.
]

{ #category : #accessing }
Refrain >> entityCollector: aRefrainEntityCollector [
	entityCollector := aRefrainEntityCollector
]

{ #category : #accessing }
Refrain >> firstCommit: anObject [
	firstCommit := anObject
]

{ #category : #initialization }
Refrain >> initialize [
	super initialize.
	entityCollector := self class defaultEntityCollectorClass new.
	maxNumberOfEntities := self class defaultMaxNumberOfEntities.
]

{ #category : #testing }
Refrain >> isMethodChangeRelevant: aMethodChange [
	"Only method changes that a non-empty list of both added and deleted entities can be relevant for mining frequent entity replacements"
	(aMethodChange addedEntities isNotEmpty and: [ aMethodChange deletedEntities isNotEmpty ])
		ifFalse: [ ^ false ].
		
	"Method changes that have too many deleted or added entities are irrelevant because the method changed too much - perhaps it was completely rewritten - and we can not use it to infer small specific changes"
	^ aMethodChange addedEntities size <= maxNumberOfEntities and: [
		aMethodChange deletedEntities size <= maxNumberOfEntities ]
]

{ #category : #accessing }
Refrain >> lastCommit: anObject [
	lastCommit := anObject
]

{ #category : #'as yet unclassified' }
Refrain >> loadMethodChanges [	
	methodChanges := methodChangeCollector
		collectMethodChangesFromCommit: firstCommit
		toCommit: lastCommit.
	
	methodChanges do: [ :change |
		entityCollector extractAddedAndDeletedEntitiesFrom: change ].
	
	relevantMethodChanges := methodChanges select: [ :change |
		self isMethodChangeRelevant: change ].
]

{ #category : #accessing }
Refrain >> maxNumberOfAddedAndDeletedEntitiesInMethodChange: aNumber [
	maxNumberOfEntities := aNumber
]

{ #category : #accessing }
Refrain >> methodChanges [
	^ methodChanges
]

{ #category : #accessing }
Refrain >> minNumberOfRepetitions: aNumber [
	minNumberOfRepetitions := aNumber
]

{ #category : #'as yet unclassified' }
Refrain >> mineRepetitiveChanges [
	self loadMethodChanges.
	self mineRules.
	^ rules
]

{ #category : #'as yet unclassified' }
Refrain >> mineRules [
	| miner |
	miner := RefrainMiner new.
	
	rules := miner
		mineRulesFrom: relevantMethodChanges
		withMinNumberOfRepetitions: minNumberOfRepetitions.
		
	self sortRules.
]

{ #category : #accessing }
Refrain >> relevantMethodChanges [
	^ relevantMethodChanges
]

{ #category : #accessing }
Refrain >> repository: aRepository [
	methodChangeCollector := RefrainMethodChangeCollector forRepository: aRepository
]

{ #category : #'as yet unclassified' }
Refrain >> repositoryName: aString [
	self repository: (IceRepository registry detect: [ :repo |
		repo isValid and: [ repo name = aString ] ]).
]

{ #category : #accessing }
Refrain >> rules [
	^ rules
]

{ #category : #sorting }
Refrain >> sortRules [
	"Sort first by lift then by confidence then by count"
	rules sort: [ :a :b |
		a lift > b lift or: [ 
			a lift = b lift and: [ a confidence > b confidence or: [ 
				a confidence = b confidence and: [ a count > b count ] ] ] ] ].
]
