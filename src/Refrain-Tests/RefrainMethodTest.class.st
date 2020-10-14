Class {
	#name : #RefrainMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'method1',
		'method2',
		'method3',
		'method4'
	],
	#category : #'Refrain-Tests-Models'
}

{ #category : #running }
RefrainMethodTest >> setUp [
	super setUp.
	
	method1 := RefrainMethod new 
		className: 'Object';
		selector: 'new';
		yourself.
		
	"Same as method1"
	method2 := RefrainMethod new 
		className: 'Object';
		selector: 'new';
		yourself.
		
	"Different className"
	method3 := RefrainMethod new 
		className: 'Collection';
		selector: 'new';
		yourself.
		
	"Different selector"
	method4 := RefrainMethod new 
		className: 'Object';
		selector: 'initialize';
		yourself.
]

{ #category : #tests }
RefrainMethodTest >> testEquality [ 
	self assert: method2 equals: method1.
	self deny: method3 equals: method1.
	self deny: method4 equals: method1.
]

{ #category : #tests }
RefrainMethodTest >> testHash [
	self assert: method2 hash equals: method1 hash.
	self deny: method3 hash equals: method1 hash.
	self deny: method4 hash equals: method1 hash.
]

{ #category : #tests }
RefrainMethodTest >> testSet [
	| set |
	set := { method1 . method2 . method3 . method4 } asSet.
	
	self assert: set size equals: 3.
	self assert: (set includes: method1).
	self assert: (set includes: method2).
	self assert: (set includes: method3).
	self assert: (set includes: method4).
]
