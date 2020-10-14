Class {
	#name : #RefrainTestsAprioriMockMethods,
	#superclass : #Object,
	#instVars : [
		'associationRuleMetrics',
		'associationRules',
		'itemsetMetrics',
		'frequentItemsets'
	],
	#category : #'Refrain-Tests-Mocks'
}

{ #category : #'as yet unclassified' }
RefrainTestsAprioriMockMethods >> newSourceCode1 [
	^ 'calculateItemsetMetrics: aCollectionOfMetricsClasses

	itemsetMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	frequentItemsets do: [ :itemset |
		itemsetMetrics do: [ :metric |
			itemset metricsValues at: metric class put: (metric valueForItemset: itemset) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainTestsAprioriMockMethods >> newSourceCode2 [
	^ 'calculateAssociationRuleMetrics: aCollectionOfMetricsClasses

	associationRuleMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	associationRules do: [ :rule |
		associationRuleMetrics do: [ :metric |
			rule metricsValues at: metric class put: (metric valueForAssociationRule: rule) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainTestsAprioriMockMethods >> oldSourceCode1 [
	^ 'calculateItemsetMetrics: aCollectionOfMetricsClasses

	itemsetMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	frequentItemsets do: [ :itemset |
		itemsetMetrics do: [ :metric |
			itemset metrics at: metric class put: (metric valueForItemset: itemset) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainTestsAprioriMockMethods >> oldSourceCode2 [
	^ 'calculateAssociationRuleMetrics: aCollectionOfMetricsClasses

	associationRuleMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	associationRules do: [ :rule |
		associationRuleMetrics do: [ :metric |
			rule metrics at: metric class put: (metric valueForAssociationRule: rule) ] ]'
]
