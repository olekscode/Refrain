Class {
	#name : #RefrainMethodChangeCollector,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainMethodChangeCollector class >> forRepository: aRepository [
	^ self new initializeRepository: aRepository; yourself. 
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
		
	commit := aCollectionOfIceCommits last.
	diffs add: (commit diffTo: commit parent).
	
	^ diffs
]

{ #category : #public }
RefrainMethodChangeCollector >> collectMethodChangesFromCommit: anOldestCommitSha toCommit: aNewestCommitSha [
	| oldestIceCommit newestIceCommit commits diffs |
	
	oldestIceCommit := self iceCommitFromSha: anOldestCommitSha.
	newestIceCommit := self iceCommitFromSha: aNewestCommitSha.
	
	commits := self loadIceCommitsFrom: oldestIceCommit to: newestIceCommit.
	diffs := self calculateDiffsForCommits: commits.
	
	^ self extractMethodChangesFromDiffs: diffs.
]

{ #category : #accessing }
RefrainMethodChangeCollector >> commits [
	"All commits of a repository"
	^ project commits values
]

{ #category : #private }
RefrainMethodChangeCollector >> extractAllCommitsFromRepository [
	"Extract commits from all branches of a repository"
	| allCommits |
	
	allCommits := (project repository allBranches flatCollect: [ :branch | branch commits ]) asSet.
	
	project iceCommits removeAll.
	project commits removeAll.
	
	allCommits do: [ :commit |
		project iceCommits at: commit id put: commit.
		project commits at: commit id put: commit asRefrainCommit ].
	
	project repository tags do: [ :tag |
		project commits
			at: tag commit id
			ifPresent: [ :commit | commit tags add: tag name ] ].
]

{ #category : #private }
RefrainMethodChangeCollector >> extractMethodChangesFromDiff: aDiff [
	| methodOperations |
	methodOperations := self extractOperationsFromDiff: aDiff.

	^ methodOperations
		select: [ :each | each isMethodChange ]
		thenCollect: [ :each |
			each asRefrainMethodChange
				commit: aDiff sourceVersion asRefrainCommit;
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
	^ project iceCommits
		at: aCommitSha
		ifAbsent: [ Error signal: 'Commit with this SHA was not found' ]
]

{ #category : #initialization }
RefrainMethodChangeCollector >> initialize [
	super initialize.
	project := RefrainProject new.
]

{ #category : #initialization }
RefrainMethodChangeCollector >> initializeRepository: aRepository [
	project repository: aRepository.
	self extractAllCommitsFromRepository.
]

{ #category : #private }
RefrainMethodChangeCollector >> loadIceCommitsFrom: anOldestIceCommit to: aNewestIceCommit [
	| commits commitWalk |
	
	commitWalk := (IceLibgitCommitWalk forRepository: project repository)
		fromCommit: aNewestIceCommit;
		uptoCommit: anOldestIceCommit;
		yourself.
		
	commits := OrderedCollection new.
	commitWalk commitsDo: [ :commit | commits add: commit ].
	commits add: anOldestIceCommit.
	
	^ commits reversed
]
