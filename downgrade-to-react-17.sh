#!/bin/bash

TOP=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

for package_file in $(find $TOP -name package.json ! -path "$TOP/node_modules/*"); do
    echo "Processing $package_file"
    sed -i 's|"react": "\^18\.[0-9]\+\.[0-9]\+"|"react": "^17.0.0"|g' $package_file
    sed -i 's|"react-dom": "\^18\.[0-9]\+\.[0-9]\+"|"react-dom": "^17.0.0"|g' $package_file
    sed -i 's|"@types/react": "\^18\.[0-9]\+\.[0-9]\+"|"@types/react": "^17.0.0"|g' $package_file
    sed -i 's|"@types/react-dom": "\^18\.[0-9]\+\.[0-9]\+"|"@types/react-dom": "^17.0.0"|g' $package_file
done

DEMOS_INDEX_FILES=(
    "$TOP/examples/crm/src/index.tsx"
    "$TOP/examples/demo/src/index.tsx"
    "$TOP/examples/simple/src/index.tsx"
)

for demo_index_file in ${DEMOS_INDEX_FILES[@]}; do
    echo "Processing $demo_index_file"
    sed -i "s|import { createRoot } from 'react-dom\/client';|import { render } from 'react-dom';|g" $demo_index_file
    sed -i "s|import ReactDOM from 'react-dom\/client';|import ReactDOM from 'react-dom';|g" $demo_index_file
    perl -i -0777 -pe 's/createRoot\((.*?)(?: as HTMLElement|)\)\.render\(((?:.*|\n)*?)\);/render(\2, \1);/g' $demo_index_file
done

