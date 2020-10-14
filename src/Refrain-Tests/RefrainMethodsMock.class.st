Class {
	#name : #RefrainMethodsMock,
	#superclass : #Object,
	#instVars : [
		'associationRuleMetrics',
		'associationRules',
		'itemsetMetrics',
		'frequentItemsets'
	],
	#category : #'Refrain-Tests-Mocks'
}

{ #category : #enumerating }
RefrainMethodsMock >> mockNewSelect: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. Collect into a new collection like the receiver, only those elements for which aBlock evaluates to true. Answer the new collection."
	"(#(1 2 3 4 5) select: #even) >>> #(2 4)"
	
	| newCollection |
	newCollection := self copyEmpty.
	self do: [ :each | 
		(aBlock value: each) not
			ifFalse: [ newCollection add: each ]].
	^newCollection
]

{ #category : #enumerating }
RefrainMethodsMock >> mockOldSelect: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. Collect into a new collection like the receiver, only those elements for which aBlock evaluates to true. Answer the new collection."
	"(#(1 2 3 4 5) select: #even) >>> #(2 4)"
	
	| newCollection |
	newCollection := self copyEmpty.
	self do: [ :each | 
		(aBlock value: each) 
			ifTrue: [ newCollection add: each ]].
	^newCollection
]
