Class {
	#name : #Refrain,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch',
		'firstCommit',
		'lastCommit',
		'minNumberOfRepetitions',
		'methodChanges',
		'entityCollector',
		'rules'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
Refrain class >> defaultEntityCollectoClass [
	^ RefrainSelectorCollector
]

{ #category : #'as yet unclassified' }
Refrain class >> repositoryName: aRepositoryName branchName: aBranchName firstCommit: aFirstCommit lastCommit: aLastCommit [
	^ self new
		repositoryName: aRepositoryName;
		branchName: aBranchName;
		firstCommit: aFirstCommit;
		lastCommit: aLastCommit;
		yourself.
]

{ #category : #'as yet unclassified' }
Refrain >> branchName: aString [
	branch := repository branchNamed: aString.
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
	entityCollector := self class defaultEntityCollectoClass new.
]

{ #category : #accessing }
Refrain >> lastCommit: anObject [
	lastCommit := anObject
]

{ #category : #'as yet unclassified' }
Refrain >> loadMethodChanges [
	| methodChangeCollector |
	
	methodChangeCollector := RefrainMethodChangeCollector
		forRepository: repository
		branch: branch.
	
	methodChanges := methodChangeCollector
		collectMethodChangesFromCommit: firstCommit
		toCommit: lastCommit.
	
	methodChanges do: [ :change |
		entityCollector extractAddedAndDeletedEntitiesFrom: change ].
]

{ #category : #accessing }
Refrain >> methodChanges [
	^ methodChanges
]

{ #category : #accessing }
Refrain >> minNumberOfRepetitions: anObject [
	minNumberOfRepetitions := anObject
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
		mineRulesFrom: methodChanges
		withMinNumberOfRepetitions: minNumberOfRepetitions.
		
	self sortRules.
]

{ #category : #'as yet unclassified' }
Refrain >> repositoryName: aString [
	repository := IceRepository registry detect: [ :repo |
		repo isValid and: [ repo name = aString ] ].
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
