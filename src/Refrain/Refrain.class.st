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
		'associationRules'
	],
	#category : #'Refrain-Controllers'
}

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
	branch := repository branchNamed: 'master'.
]

{ #category : #accessing }
Refrain >> firstCommit: anObject [
	firstCommit := anObject
]

{ #category : #accessing }
Refrain >> lastCommit: anObject [
	lastCommit := anObject
]

{ #category : #'as yet unclassified' }
Refrain >> loadMethodChanges [
	| methodChangeCollector methodCallCollector |
	
	methodChangeCollector := RefrainMethodChangeCollector
		forRepository: repository
		branch: branch.
	
	methodChanges := methodChangeCollector
		collectMethodChangesFromCommit: firstCommit
		toCommit: lastCommit.
		
	methodCallCollector := RefrainMethodCallCollector new.
	
	methodChanges do: [ :change |
		methodCallCollector extractAddedAndDeletedMethodCallsFrom: change ].
]

{ #category : #accessing }
Refrain >> minNumberOfRepetitions: anObject [
	minNumberOfRepetitions := anObject
]

{ #category : #'as yet unclassified' }
Refrain >> mineRepetitiveChanges [
	self loadMethodChanges.
	self mineRules.
	^ associationRules
]

{ #category : #'as yet unclassified' }
Refrain >> mineRules [
	| aprioriMiner |

	aprioriMiner := RefrainAprioriMiner new.
	
	associationRules := aprioriMiner
		mineRulesFromMethodChanges: methodChanges
		withMinCount: minNumberOfRepetitions.
		
	self sortRules.
]

{ #category : #'as yet unclassified' }
Refrain >> repositoryName: aString [
	repository := IceRepository registry detect: [ :repo |
		repo isValid and: [ repo name = aString ] ].
]

{ #category : #sorting }
Refrain >> sortRules [
	"Sort first by lift then by confidence then by count"
	associationRules sort: [ :a :b |
		a lift > b lift or: [ 
			a lift = b lift and: [ a confidence > b confidence or: [ 
				a confidence = b confidence and: [ a count > b count ] ] ] ] ].
]
