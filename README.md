# Refrain

[![Build Status](https://travis-ci.org/olekscode/Refrain.svg?branch=master)](https://travis-ci.org/olekscode/Refrain)
[![Build status](https://ci.appveyor.com/api/projects/status/t7lxsakunjyl0dan?svg=true)](https://ci.appveyor.com/project/olekscode/refrain)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/Refrain/badge.svg?branch=master)](https://coveralls.io/github/olekscode/Refrain?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/Refrain/master/LICENSE)

**Refrain** is a tool for mining repetitive changes from the commit history of Pharo projects. It is based on the [A-Priori](https://github.com/pharo-ai/APriori) algorithm which goes through the change history of a given project and identifies all possible subsets of co-occuring changes that appear at least N times. For example, if method call to `doWithIndex:` was repetitively replaced with a call to `withIndexDo:` then Refrain will identify `#doWithIndex: ->  #withIndexDo:` as a repetitive change.

In music and poetry, [_"refrain"_](https://en.wikipedia.org/wiki/Refrain) is the repetive phrase or verse, for example, a chorus of a song or repetitive lines in a poem.

> O Captain! my Captain! our fearful trip is done,  
The ship has weather’d every rack, the prize we sought is won,  
...  
O Captain! my Captain! rise up and hear the bells;  
Rise up—for you the flag is flung—for you the bugle trills,  
...

&mdash; _extract from [O Captain! My Captain!](https://www.poetryfoundation.org/poems/45474/o-captain-my-captain) by Walt Whitman_

## How to install it?

To install Refrain, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Refrain';
  repository: 'github://olekscode/Refrain/src';
  load.
```

## How to depend on it?

If you want to add a dependency on Refrain to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'Refrain'
  with: [ spec repository: 'github://olekscode/Refrain/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?
