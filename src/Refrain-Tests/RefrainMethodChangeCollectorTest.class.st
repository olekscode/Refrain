Class {
	#name : #RefrainMethodChangeCollectorTest,
	#superclass : #TestCase,
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainMethodChangeCollectorTest >> testCollectMethodChangesFromCommitToCommit [
	| commit1 commit2 method1 method2 change1 change2 repository branch collector expectedMethodChanges actualMethodChanges |
	
	commit1 := RefrainCommit new
		sha: '84ed7471d4a6c0f5c070a6bfe8ab3371f0188035';
		message: 'Fixed a bug';
		author: 'olekscode';
		datetime: '27 April 2020, 16:53:12' asDateAndTime;
		yourself.
	
	commit2 := RefrainCommit new
		sha: '57acf893b567393fec7967f0c32306fccda9321d';
		message: 'Fixed a bug';
		author: 'Oleksandr Zaitsev';
		datetime: '26 August 2020, 20:41:40' asDateAndTime;
		yourself.
		
	method1 := RefrainMethod new
		className: #APriori;
		selector: #calculateItemsetMetrics:;
		yourself.
	
	method2 := RefrainMethod new
		className: #APriori;
		selector: #calculateAssociationRuleMetrics:;
		yourself.
		
	change1 := RefrainMethodChange new 
		method: method1;
		commit: commit1;
		oldSourceCode: RefrainTestsAprioriMockMethods new oldSourceCode1;
		newSourceCode: RefrainTestsAprioriMockMethods new newSourceCode1;
		yourself.
	
	change2 := RefrainMethodChange new 
		method: method2;
		commit: commit2;
		oldSourceCode: RefrainTestsAprioriMockMethods new oldSourceCode2;
		newSourceCode: RefrainTestsAprioriMockMethods new newSourceCode2;
		yourself.
	
	repository := IceRepository registry detect: [ :repo |
		repo isValid and: [ repo name = 'APriori' ] ].
	
	branch := repository branchNamed: 'master'.
	
	collector := RefrainMethodChangeCollector
		forRepository: repository
		branch: branch.
		
	expectedMethodChanges := { change1 . change2 } asOrderedCollection.
	actualMethodChanges := collector collectMethodChangesFromCommit: commit1 toCommit: commit2.
	
	self assert: actualMethodChanges first equals: expectedMethodChanges first.
	self assert: actualMethodChanges second equals: expectedMethodChanges second.
	self assert: actualMethodChanges equals: expectedMethodChanges.
]
