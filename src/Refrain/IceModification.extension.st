Extension { #name : #IceModification }

{ #category : #'*Refrain' }
IceModification >> asRefrainMethodChange [
	| method |
	method := RefrainMethod new 
		className: self definition className;
		selector: self definition name;
		yourself.
		
	^ RefrainMethodChange new
		method: method;
		oldSourceCode: self oldNode sourceCode;
		newSourceCode: self definition sourceCode;
		yourself.
]

{ #category : #'*Refrain' }
IceModification >> isMethodChange [
	(definition isMethodDefinition and: [ oldNode isMethodDefinition ])
		ifFalse: [ ^ false ].
		
	definition className = oldNode className 
		ifFalse: [ ^ false ].
		
	definition name = oldNode name
		ifFalse: [ ^ false ].
		
	^ true
]
