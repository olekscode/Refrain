Extension { #name : #IceGitCommit }

{ #category : #'*Refrain' }
IceGitCommit >> asRefrainCommit [
	^ RefrainCommit new 
		sha: self id;
		message: self comment;
		author: self author;
		datetime: self datetime;
		yourself
]
