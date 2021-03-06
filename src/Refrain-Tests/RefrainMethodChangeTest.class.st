Class {
	#name : #RefrainMethodChangeTest,
	#superclass : #TestCase,
	#instVars : [
		'change1',
		'change2',
		'change3',
		'change4',
		'change5',
		'change6',
		'change7',
		'change8'
	],
	#category : #'Refrain-Tests-Models'
}

{ #category : #running }
RefrainMethodChangeTest >> setUp [
	| method1 method2 commitSha1 commitSha2 call1 call2 call3 call4 call5 |
	super setUp.
	
	method1 := RefrainMethod new 
		className: #Collection;
		selector: #do:;
		yourself.
		
	method2 := RefrainMethod new 
		className: #Object;
		selector: #new;
		yourself.
		
	commitSha1 := '14164de82d938df2cc98186fa0225a49fe7c98e0'.
	commitSha2 := '3206cc82d9991e2acdd10916247c114e1b173e77'.
	
	call1 := RefrainSelectorEntity new
		selector: #add:;
		makeAdded;
		yourself.
		
	call2 := RefrainSelectorEntity new
		selector: #insert:;
		makeDeleted;
		yourself.
		
	call3 := RefrainSelectorEntity new 
		selector: #remove:;
		makeAdded;
		yourself.
		
	call4 := RefrainSelectorEntity new 
		selector: #delete:;
		makeDeleted;
		yourself.
		
	call5 := RefrainSelectorEntity new
		selector: #sum;
		makeAdded;
		yourself.
	
	change1 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Same as change1"
	change2 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Different method"
	change3 := RefrainMethodChange new 
		method: method2;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Different commit"
	change4 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha2;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Different oldSourceCode"
	change5 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '3 * 5 asFloat';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Different newSourceCode"
	change6 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '5 minus: 4';
		addedEntities: { call1 . call3 };
		deletedEntities: { call2 };
		yourself.
		
	"Different addedMethodCalls"
	change7 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call5 };
		deletedEntities: { call2 };
		yourself.
		
	"Different deletedMethodCalls"
	change8 := RefrainMethodChange new 
		method: method1;
		commitSha: commitSha1;
		oldSourceCode: '1 + 2';
		newSourceCode: '1 add: 2';
		addedEntities: { call1 . call3 };
		deletedEntities: { call4 };
		yourself.
]

{ #category : #tests }
RefrainMethodChangeTest >> testEquality [ 
	self assert: change2 equals: change1.
	self deny: change3 equals: change1.
	self deny: change4 equals: change1.
	self deny: change5 equals: change1.
	self deny: change6 equals: change1.
	self deny: change7 equals: change1.
	self deny: change8 equals: change1.
]

{ #category : #tests }
RefrainMethodChangeTest >> testHash [
	self assert: change2 hash equals: change1 hash.
	self deny: change3 hash equals: change1 hash.
	self deny: change4 hash equals: change1 hash.
	self deny: change5 hash equals: change1 hash.
	self deny: change6 hash equals: change1 hash.
	self deny: change7 hash equals: change1 hash.
	self deny: change8 hash equals: change1 hash.
]

{ #category : #tests }
RefrainMethodChangeTest >> testSet [
	| set |
	set := { change1 . change2 . change3 . change4 . change5 . change6 . change7 . change8 } asSet.
	
	self assert: set size equals: 7.
	self assert: (set includes: change1).
	self assert: (set includes: change2).
	self assert: (set includes: change3).
	self assert: (set includes: change4).
	self assert: (set includes: change5).
	self assert: (set includes: change6).
	self assert: (set includes: change7).
	self assert: (set includes: change8).
]
