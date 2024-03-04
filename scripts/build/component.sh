#!/bin/sh -e

export NODE_ENV=production
mkdir -p build/lib dist
babel lib/{index,Autocomplete}.js -d build/
cd dist
browserify ../lib/Autocomplete.js \
    --transform babelify \
    --external react \
    --external react-dom \
    --debug \
  | youemdee ReactAutocomplete \
    --dependency react:React \
    --dependency react-dom:ReactDOM \
  | exorcist react-autocomplete.js.map \
  > react-autocomplete.js
uglifyjs react-autocomplete.js -cmo react-autocomplete.min.js \
    --compress \
    --mangle \
    --source-map url=react-autocomplete.min.js.map
