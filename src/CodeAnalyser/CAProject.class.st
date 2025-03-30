Class {
	#name : 'CAProject',
	#superclass : 'Object',
	#instVars : [
		'baseline',
		'loadedPackages'
	],
	#category : 'CodeAnalyser',
	#package : 'CodeAnalyser'
}

{ #category : 'instance creation' }
CAProject class >> fromBaseline: aBaseline [

	^ self new
		initializeFromBaseline: aBaseline;
		yourself
]

{ #category : 'accessing' }
CAProject >> baseline [

	^ baseline
]

{ #category : 'initialization' }
CAProject >> initialize [
	
	super initialize.
	loadedPackages := OrderedCollection new.
]

{ #category : 'initialization' }
CAProject >> initializeFromBaseline: aBaseline [

	baseline := aBaseline.
	loadedPackages := self loadedPackagesFromBaseline: aBaseline.
]

{ #category : 'as yet unclassified' }
CAProject >> inspectionPackages [
	<inspectorPresentationOrder: 0 title: 'Packages'>
	
	^ SpListPresenter new
		items: loadedPackages;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: #package ];
		yourself.
]

{ #category : 'inspecting' }
CAProject >> inspectionStats [
	<inspectorPresentationOrder: 0 title: 'Stats'>
	| statPragmas |
	
	statPragmas := Pragma allNamed: 'statNamed:' in: self class.
	
	^ SpTablePresenter new
		alternateRowsColor;
		items: statPragmas;
		addColumn: (SpStringTableColumn 
			title: 'Title'
			evaluated: [ :pragma | pragma argument ]) ;
		addColumn: (SpStringTableColumn 
			title: 'Value' 
			evaluated: [ :pragma | self perform: pragma method selector ]).
]

{ #category : 'accessing' }
CAProject >> loadedPackages [

	^ loadedPackages
]

{ #category : 'as yet unclassified' }
CAProject >> loadedPackagesFromBaseline: aBaseline [

	| packageNames packages |
	
	packageNames := self packageNamesFromBaseline: aBaseline.
	packages := OrderedCollection new.
	
	packageNames do: [ :name |
		[ packages add: name asPackage ] onErrorDo: [ "nothing" ] ].

	^ packages 
]

{ #category : 'stats' }
CAProject >> numberOfPackages [

	<statNamed: 'Number of packages'>
	^ loadedPackages size
]

{ #category : 'as yet unclassified' }
CAProject >> packageNamesFromBaseline: aBaseline [

	^ aBaseline project version spec packageSpecsInLoadOrder
		select: [ :each | each type = 'package' ]
		thenCollect: [ :each | each name ]
]
