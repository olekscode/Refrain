Class {
	#name : #BaselineOfRefrain,
	#superclass : #BaselineOf,
	#category : #BaselineOfRefrain
}

{ #category : #baselines }
BaselineOfRefrain >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'APriori'
			with: [ spec repository: 'github://pharo-ai/APriori/src' ].
			
		spec
  			baseline: 'Clio'
  			with: [ spec repository: 'github://olekscode/Clio:v0.1/src' ].
				
		"Packages"
		spec 
			package: 'Refrain' with: [ spec requires: #('APriori' 'Clio') ];
			package: 'Refrain-Tests' with: [ spec requires: #('Refrain') ] ]
]
