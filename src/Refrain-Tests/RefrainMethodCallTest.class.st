Class {
	#name : #RefrainMethodCallTest,
	#superclass : #TestCase,
	#instVars : [
		'call1',
		'call2',
		'call3',
		'call4',
		'call5'
	],
	#category : #'Refrain-Tests-Models'
}

{ #category : #running }
RefrainMethodCallTest >> setUp [
	super setUp.
	
	call1 := RefrainMethodCall new 
		selector: #collect:;
		makeAdded;
		yourself.
		
	"Same as call1"
	call2 := RefrainMethodCall new 
		selector: #collect:;
		makeAdded;
		yourself.
		
	"Different selector"
	call3 := RefrainMethodCall new 
		selector: #isEmpty;
		makeAdded;
		yourself.
		
	"Different isAdded"
	call4 := RefrainMethodCall new 
		selector: #collect:;
		makeDeleted;
		yourself.
		
	"Empty isAdded"
	call5 := RefrainMethodCall new 
		selector: #collect:;
		yourself.
]

{ #category : #tests }
RefrainMethodCallTest >> testEquality [ 
	self assert: call2 equals: call1.
	self deny: call3 equals: call1.
	self deny: call4 equals: call1.
	self deny: call5 equals: call1.
]

{ #category : #tests }
RefrainMethodCallTest >> testHash [
	self assert: call2 hash equals: call1 hash.
	self deny: call3 hash equals: call1 hash.
	self deny: call4 hash equals: call1 hash.
	self deny: call5 hash equals: call1 hash.
]

{ #category : #tests }
RefrainMethodCallTest >> testSet [
	| set |
	set := { call1 . call2 . call3 . call4 . call5 } asSet.
	
	self assert: set size equals: 4.
	self assert: (set includes: call1).
	self assert: (set includes: call2).
	self assert: (set includes: call3).
	self assert: (set includes: call4).
	self assert: (set includes: call5).
]
