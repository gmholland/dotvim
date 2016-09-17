let g:projectionist_heuristics = {
			\ 	"*": {
			\		"*.cpp": {
			\ 			"alternate": "{}.h",
			\			"type": "source"
			\		},
			\		"*.h": {
			\			"alternate": "{}.cpp",
			\			"type": "header"
			\		}
			\	},
			\
			\	"src/&include/": {
			\		"src/*.cpp": {
			\ 			"alternate": "include/{}.h",
			\			"type": "source"
			\ 		},
			\		"include/*.h": {
			\			"alternate": "src/{}.cpp",
			\			"type": "header"
			\		}
			\ 	}
			\ }
