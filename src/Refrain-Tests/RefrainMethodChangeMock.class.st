Class {
	#name : #RefrainMethodChangeMock,
	#superclass : #Object,
	#instVars : [
		'associationRuleMetrics',
		'associationRules',
		'itemsetMetrics',
		'frequentItemsets'
	],
	#category : #'Refrain-Tests-Mocks'
}

{ #category : #accessing }
RefrainMethodChangeMock >> branch [
	^ self repository branchNamed: 'master'.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> commit1 [
	^ RefrainCommit new
		sha: '84ed7471d4a6c0f5c070a6bfe8ab3371f0188035';
		message: 'Fixed a bug';
		author: 'olekscode';
		datetime: '27 April 2020, 14:53:12+00:00' asDateAndTime;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> commit2 [
	^ RefrainCommit new
		sha: '57acf893b567393fec7967f0c32306fccda9321d';
		message: 'Fixed a bug';
		author: 'Oleksandr Zaitsev';
		datetime: '26 August 2020, 18:41:40+00:00' asDateAndTime;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> method1 [
	^ RefrainMethod new
		className: #APriori;
		selector: #calculateItemsetMetrics:;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> method2 [
	^ RefrainMethod new
		className: #APriori;
		selector: #calculateAssociationRuleMetrics:;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodCall1 [
	^ RefrainSelectorEntity new
		selector: #metrics;
		makeDeleted;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodCall2 [
	^ RefrainSelectorEntity new
		selector: #metricValues;
		makeAdded;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodChange1 [
	^ RefrainMethodChange new 
		method: self method1;
		commit: self commit1;
		oldSourceCode: self oldSourceCode1;
		newSourceCode: self newSourceCode1;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodChange2 [
	^ RefrainMethodChange new 
		method: self method2;
		commit: self commit2;
		oldSourceCode: self oldSourceCode2;
		newSourceCode: self newSourceCode2;
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodChangeWithCalls1 [
	^ self methodChange1
		deletedEntities: { self methodCall1 };
		addedEntities: { self methodCall2 };
		yourself.
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> methodChangeWithCalls2 [
	^ self methodChange2
		deletedEntities: { self methodCall1 };
		addedEntities: { self methodCall2 };
		yourself.
]

{ #category : #accessing }
RefrainMethodChangeMock >> methodChanges [
	^ OrderedCollection withAll: {
		self methodChange1 .
		self methodChange2 }
]

{ #category : #accessing }
RefrainMethodChangeMock >> methodChangesWithCalls [
	^ OrderedCollection withAll: {
		self methodChangeWithCalls1 .
		self methodChangeWithCalls2 }
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> newSourceCode1 [
	^ 'calculateItemsetMetrics: aCollectionOfMetricsClasses

	itemsetMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	frequentItemsets do: [ :itemset |
		itemsetMetrics do: [ :metric |
			itemset metricsValues at: metric class put: (metric valueForItemset: itemset) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> newSourceCode2 [
	^ 'calculateAssociationRuleMetrics: aCollectionOfMetricsClasses

	associationRuleMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	associationRules do: [ :rule |
		associationRuleMetrics do: [ :metric |
			rule metricsValues at: metric class put: (metric valueForAssociationRule: rule) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> oldSourceCode1 [
	^ 'calculateItemsetMetrics: aCollectionOfMetricsClasses

	itemsetMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	frequentItemsets do: [ :itemset |
		itemsetMetrics do: [ :metric |
			itemset metrics at: metric class put: (metric valueForItemset: itemset) ] ]'
]

{ #category : #'as yet unclassified' }
RefrainMethodChangeMock >> oldSourceCode2 [
	^ 'calculateAssociationRuleMetrics: aCollectionOfMetricsClasses

	associationRuleMetrics := self instantiateMetrics: aCollectionOfMetricsClasses.

	associationRules do: [ :rule |
		associationRuleMetrics do: [ :metric |
			rule metrics at: metric class put: (metric valueForAssociationRule: rule) ] ]'
]

{ #category : #accessing }
RefrainMethodChangeMock >> repository [
	^ IceRepository registry detect: [ :repo |
		repo isValid and: [ repo name = 'APriori' ] ].
]
