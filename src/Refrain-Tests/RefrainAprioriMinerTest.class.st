Class {
	#name : #RefrainAprioriMinerTest,
	#superclass : #TestCase,
	#instVars : [
		'methodChange'
	],
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainAprioriMinerTest >> testMineRulesFromMethodChangesWithMinCount [
	| miner mock expected actual |
	
	miner := RefrainAprioriMiner new.
	mock := RefrainAprioriChangeMock new.
	
	expected := OrderedCollection withAll: { 
		({ mock methodCall1 } asItemset ->
		{ mock methodCall2 } asItemset
	) asAssociationRule }.
		
	actual := miner
		mineRulesFromMethodChanges: mock methodChangesWithCalls
		withMinCount: 2.
	
	self assert: actual equals: expected.
]
