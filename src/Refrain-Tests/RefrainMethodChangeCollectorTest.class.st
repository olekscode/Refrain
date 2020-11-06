Class {
	#name : #RefrainMethodChangeCollectorTest,
	#superclass : #TestCase,
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainMethodChangeCollectorTest >> testCollectMethodChangesFromCommitToCommit [
	| mock collector expectedMethodChanges actualMethodChanges |
	
	mock := RefrainMethodChangeMock new.
	
	collector := RefrainMethodChangeCollector
		forRepository: mock repository.
		
	expectedMethodChanges := mock methodChanges.
	
	actualMethodChanges := collector
		collectMethodChangesFromCommit: mock commit1 sha
		toCommit: mock commit2 sha.
	
	self assert: actualMethodChanges equals: expectedMethodChanges.
]
