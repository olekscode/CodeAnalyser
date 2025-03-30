Extension { #name : 'Package' }

{ #category : '*CodeAnalyser' }
Package >> averageLocPerMethod [

	<statNamed: 'Average LOC / method'>
	^ (self methods collect: [ :method | method linesOfCode ]) average asFloat round: 2
]

{ #category : '*CodeAnalyser' }
Package >> averageNumberOfMethodsPerClass [

	<statNamed: 'Average methods / class'>
	^ (self classes collect: [ :each | each methods size ]) average asFloat round: 2
]

{ #category : '*CodeAnalyser' }
Package >> inspectionStats [
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

{ #category : '*CodeAnalyser' }
Package >> numberOfClasses [

	<statNamed: 'Classes'>
	^ self classes size
]

{ #category : '*CodeAnalyser' }
Package >> numberOfDefinedClasses [

	<statNamed: 'Defined classes'>
	^ self definedClasses size
]

{ #category : '*CodeAnalyser' }
Package >> numberOfMethodsClasses [

	<statNamed: 'Methods'>
	^ self methods size
]
