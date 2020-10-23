Class {
	#name : #RefrainMiner,
	#superclass : #Object,
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainMiner >> filterRules: aCollectionOfRules [
	| filteredRules |
	
	filteredRules := aCollectionOfRules reject: [ :rule |
		rule key isEmpty or:
		rule value isEmpty ].
	
	filteredRules := filteredRules select: [ :rule |
		(rule key allSatisfy: [ :each | each isDeleted ]) and: [
			rule value allSatisfy: [ :each | each isAdded ] ] ].
	
	^ filteredRules 
]

{ #category : #'as yet unclassified' }
RefrainMiner >> mineRulesFrom: aCollectionOfMethodChanges withMinNumberOfRepetitions: aMinNumberOfRepetitions [ 
	| transactions transactionsSource apriori |
	
	transactions := self transactionsFromMethodChanges: aCollectionOfMethodChanges.
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.

	apriori minCount: aMinNumberOfRepetitions.
	apriori findFrequentItemsets.
	apriori buildAssociationRules.
	
	apriori calculateAssociationRuleMetrics: { 
		APrioriCountMetric .
		APrioriConfidenceMetric .
		APrioriLiftMetric }.
	
	^ self filterRules: apriori associationRules.

]

{ #category : #'as yet unclassified' }
RefrainMiner >> transactionsFromMethodChanges: aCollectionOfMethodChanges [
	^ aCollectionOfMethodChanges
		select: [ :each | each addedEntities isNotEmpty and: [ each deletedEntities isNotEmpty ] ]
		thenCollect: [ :each | (each addedEntities union: each deletedEntities) asItemset ].
]
