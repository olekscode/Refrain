Class {
	#name : #RefrainMinerTest,
	#superclass : #TestCase,
	#instVars : [
		'methodChange'
	],
	#category : #'Refrain-Tests-Controllers'
}

{ #category : #tests }
RefrainMinerTest >> testMineRulesFromMethodChangesWithMinCount [
	| miner mock expected actual |
	
	miner := RefrainMiner new.
	mock := RefrainMethodChangeMock new.
	
	expected := OrderedCollection withAll: { 
		({ mock methodCall1 } asItemset ->
		{ mock methodCall2 } asItemset
	) asAssociationRule }.
		
	actual := miner
		mineRulesFrom: mock methodChangesWithCalls
		withMinNumberOfRepetitions: 2.
	
	self assert: actual equals: expected.
]
