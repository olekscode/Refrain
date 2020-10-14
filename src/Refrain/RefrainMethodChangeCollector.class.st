Class {
	#name : #RefrainMethodChangeCollector,
	#superclass : #Object,
	#instVars : [
		'repository',
		'branch'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainMethodChangeCollector class >> forRepository: aRepository branch: aBranch [
	^ self new initializeRepository: aRepository branch: aBranch; yourself. 
]

{ #category : #private }
RefrainMethodChangeCollector >> calculateDiffsForCommits: aCollectionOfIceCommits [
	| commit diffs |
	diffs := OrderedCollection new.

	(1 to: aCollectionOfIceCommits size - 1)
		do: [ :i |
			commit := aCollectionOfIceCommits at: i.
			[ diffs add: (commit diffTo: commit parent) ]
				on: Exception
				do: [ "Nothing" ] ]
		displayingProgress: [ :i | i asString, ' / ', aCollectionOfIceCommits size asString ].
		
	^ diffs
]

{ #category : #public }
RefrainMethodChangeCollector >> collectMethodChangesFromCommit: anOldestCommit toCommit: aNewestCommit [
	| oldestIceCommit newestIceCommit commits diffs |
	
	oldestIceCommit := self iceCommitFromSha: anOldestCommit sha.
	newestIceCommit := self iceCommitFromSha: aNewestCommit sha.
	
	commits := self loadIceCommitsFrom: newestIceCommit to: oldestIceCommit.
	diffs := self calculateDiffsForCommits: commits.
	
	^ self extractMethodChangesFromDiffs: diffs.
]

{ #category : #private }
RefrainMethodChangeCollector >> extractMethodChangesFromDiff: aDiff [
	| methodOperations |
	methodOperations := self extractOperationsFromDiff: aDiff.

	^ methodOperations
		select: [ :each | each isMethodChange ]
		thenCollect: [ :each |
			each asMethodChange
				commit: aDiff sourceVersion asMrCommit;
				yourself. ].
]

{ #category : #private }
RefrainMethodChangeCollector >> extractMethodChangesFromDiffs: aCollectionOfDiffs [
	| nonEmptyDiffs |
	
	nonEmptyDiffs := aCollectionOfDiffs reject: [ :diff |
		diff tree isEmptyNode ].
	
	^ nonEmptyDiffs flatCollect: [ :diff |
		self extractMethodChangesFromDiff: diff ].
]

{ #category : #private }
RefrainMethodChangeCollector >> extractOperationsFromDiff: aDiff [
	| packageNodes classNodes methodNodes |
	
	packageNodes := aDiff tree children first children.
	classNodes := packageNodes flatCollect: [ :node |node children ].
	methodNodes := classNodes flatCollect: [ :node | node children ].
	^ methodNodes collect: [ :node | node value ].
]

{ #category : #private }
RefrainMethodChangeCollector >> iceCommitFromSha: aCommitSha [
	^ branch commits
		detect: [ :commit | commit id = aCommitSha ]
		ifNone: [ Error signal: 'Commit with this SHA was not found' ]
]

{ #category : #initialization }
RefrainMethodChangeCollector >> initializeRepository: aRepository branch: aBranch [
	repository := aRepository.
	branch := aBranch.
	^ self
]

{ #category : #private }
RefrainMethodChangeCollector >> loadIceCommitsFrom: anOldestIceCommit to: aNewestIceCommit [
	| commits commitWalk |
	
	commitWalk := (IceLibgitCommitWalk forRepository: repository)
		fromCommit: anOldestIceCommit;
		uptoCommit: aNewestIceCommit;
		yourself.
		
	commits := OrderedCollection new.
	commitWalk commitsDo: [ :commit | commits add: commit ].
	commits add: aNewestIceCommit.
	
	^ commits
]
