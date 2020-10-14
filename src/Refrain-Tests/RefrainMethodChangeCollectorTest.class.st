Class {
	#name : #RefrainMethodChangeCollectorTest,
	#superclass : #TestCase,
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainMethodChangeCollectorTest >> testCollectMethodChangesFromCommitToCommit [
	| mock collector expectedMethodChanges actualMethodChanges |
	
	mock := RefrainAprioriChangeMock new.
	
	collector := RefrainMethodChangeCollector
		forRepository: mock repository
		branch: mock branch.
		
	expectedMethodChanges := mock methodChanges.
	
	actualMethodChanges := collector
		collectMethodChangesFromCommit: mock commit1
		toCommit: mock commit2.
	
	self assert: actualMethodChanges first equals: expectedMethodChanges first.
	self assert: actualMethodChanges second equals: expectedMethodChanges second.
	self assert: actualMethodChanges equals: expectedMethodChanges.
]
