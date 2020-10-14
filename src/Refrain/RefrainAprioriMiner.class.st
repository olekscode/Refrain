Class {
	#name : #RefrainAprioriMiner,
	#superclass : #Object,
	#category : #'Refrain-Controllers'
}

{ #category : #'as yet unclassified' }
RefrainAprioriMiner >> filterAssociationRules: aCollectionOfRules [
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
RefrainAprioriMiner >> mineRulesFromMethodChanges: aCollectionOfMethodChanges withMinCount: aCountThreshold [ 
	| transactions transactionsSource apriori |
	
	transactions := self transactionsFromMethodChanges: aCollectionOfMethodChanges.
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.

	apriori minCount: aCountThreshold.
	apriori findFrequentItemsets.
	apriori buildAssociationRules.
	
	apriori calculateAssociationRuleMetrics: { 
		APrioriCountMetric .
		APrioriConfidenceMetric .
		APrioriLiftMetric }.
	
	^ self filterAssociationRules: apriori associationRules.

]

{ #category : #'as yet unclassified' }
RefrainAprioriMiner >> transactionsFromMethodChanges: aCollectionOfMethodChanges [
	^ aCollectionOfMethodChanges
		select: [ :each | each addedEntities isNotEmpty and: [ each deletedEntities isNotEmpty ] ]
		thenCollect: [ :each | (each addedEntities union: each deletedEntities) asItemset ].
]
