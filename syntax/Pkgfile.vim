" vim: ft=vim
" Language: CRUX Pkgfile
" Original Author: Tim Biermann

" sensible defaults {{{
" quit when a syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

" rely on bash syntax
let b:main_syntax = 'bash'
let b:is_bash = 1
runtime! syntax/bash.vim

" match case on
syn case match
" }}}

syn match pDescriptionStart /^# Description:/ contained
syn region pDescriptionGroup start=+^# Description:+ end=+$+ contains=pValidDescription,pInvalidDescription oneline
syn match pValidDescription /^\(# Description:\s\+\zs.\{,64}\)/ contained containedin=pDescriptionGroup
syn match pInvalidDescription /\%>64v.\+/ contained containedin=pDescriptionGroup

syn match pURLPrefix /^# URL:\s*/ contained
syn match pValidURL /\vhttps?:\/\/[[:alnum:]\/_#.-]+/ contained
syn match pInvalidURL /\vhttps?:\/\/[[:alnum:]%\/_#.-]*\s+/ contained
syn region pURLGroup start=/^# URL:/ end=/$/ contains=pURLPrefix,pValidURL,pInvalidURL

syn match pMaintainer /^# Maintainer:/ contained
syn match pValidMaintainer /\([[:alnum:],'\-#:\n ]\)/ contained contains=pMaintainer
syn match pInvalidMaintainer /\(@\|.\)/ contained contains=pValidMaintainer,pMaintainer
syn match pMaintainerGroup /^# Maintainer:.*$/ contains=pMaintainer,pValidMaintainer,pInvalidMaintainer

syn match pDependsOn /^# Depends on:/ contained
syn match pValidDependsOn /\([[:alnum:]#:\- ]\)/ contained contains=pDependsOn
syn match pInvalidDependsOn /\([^[:alnum:]#:\- ]\)/ contained contains=pValidDependsOn,pDependsOn
syn match pDependsOn /^# Depends on:.*$/ contains=pValidDependsOn,pInvalidDependsOn,pDependsOn

syn match pOptional /^# Optional:/ contained
syn match pValidOptional /\([[:alnum:]#:\- ]\)/ contained contains=pOptional
syn match pInvalidOptional /\([^[:alnum:]#:\- ]\)/ contained contains=pValidOptional,pOptional
syn match pOptional /^# Optional:.*$/ contains=pValidOptional,pInvalidOptional,pOptional

syn match pName /^name=/ contained
syn match pValidName /[[a-z0-9\-+=_]/ contained contains=pName
syn match pInvalidName /[A-Z]\|[^[:digits:]\-+=_]\|[^a-z]/ contained contains=pValidName,pName
syn match pNameGroup /^name=.*$/ contains=pValidName,pInvalidName,pName

syn match pVersion /^version=/ contained
syn match pValidVersion /[[:alnum:]+\-._]*/ contained contains=pVersion
syn match pInvalidVersion /[^[:alnum:]=+._-]/ contained contains=pValidVersion,pVersion
syn match pVersionGroup /^version=.*$/ contains=pValidVersion,pInvalidVersion,pVersion

syn match pRelease /release=/ contained
syn match pValidRelease /[1-9]\+[0-9]*/ contained contains=pRelease
syn match pInvalidRelease /\<0\>\|[^[:digit:]=]/ contained contains=pValidRelease,pRelease
syn match pReleaseGroup /^release=.*$/ contains=pValidRelease,pInvalidRelease,pRelease

syn match pSourceKeyword /^source/ contained
syn match pSourceEquals /\v\=/ contained
syn region pSourceRegion start="^\s*source\s*=" end=/)/ keepend contains=pSourceKeyword,pSourceEquals,pValidSourceURL,pInvalidSourceURL,pFile,pVariable,pSourceParens,pWhitespace
syn match pSourceParens /[()]/ contained containedin=pSourceRegion
syn match pWhitespace /\s\+/ contained containedin=pSourceRegion
syn match pValidSourceURL /\(https\?:\/\/\|ftp:\/\/\)[a-zA-Z0-9._\/$\-{}]*[a-zA-Z0-9\/]/ contained containedin=pSourceRegion
syn match pInvalidSourceURL /\(http\?:\/\/.*\.dl\.sourceforge\.net\)/ contained containedin=pSourceRegion
syn match pFile /\<[a-zA-Z0-9._-]\+\.\(tar\.[bgx]z2\|tar\|gz\|zip\|rar\|7z\|patch\|txt\|dll\)\>/ contained containedin=pSourceRegion
syn match pVariable /\$[a-zA-Z_][a-zA-Z0-9_]*/ contained containedin=pSourceRegion

syn clear shStatement
syn keyword shStatement alias break cd chdir continue eval exec exit kill newgrp pwd read readonly return shift test trap ulimit umask wait
syn keyword shStatement bg builtin disown export false fg getopts jobs let printf sleep true unalias typeset fc hash history suspend times type bind builtin caller compopt declare dirs disown enable export help logout mapfile popd pushd readarray shopt typeset

syn match shellCmd /^\s*\(prt-get\|prt-cache\)\>/ containedin=ALL

syn match validPython3Path /^\s*\/usr\/bin\/python3/ containedin=ALL
syn match invalidPython3Path /^\s*python3/ containedin=ALL

hi def link pDescriptionStart Comment
hi def link pDescriptionGroup Comment
hi def link pValidDescription Identifier
hi def link pInvalidDescription Error

hi def link pURLPrefix Comment
hi def link pValidURL Identifier
hi def link pInvalidURL Error
hi def link pURLGroup Comment

hi def link pValidMaintainer Identifier
hi def link pInvalidMaintainer Error
hi def link pMaintainer Comment

hi def link pValidDependsOn Identifier
hi def link pInvalidDependsOn Error
hi def link pDependsOn Comment

hi def link pValidOptional Structure
hi def link pInvalidOptional Error
hi def link pOptional Comment

hi def link pValidName Identifier
hi def link pInvalidName Error
hi def link pName Comment

hi def link pValidVersion Identifier
hi def link pInvalidVersion Error
hi def link pVersion Comment

hi def link pSourceKeyword Comment
hi def link pSourceEquals Comment
hi def link pSourceParens Delimiter
hi def link pValidSourceURL Identifier
hi def link pInvalidSourceURL Error
hi def link pFile Type
hi def link pVariable Macro

hi def link pValidRelease Identifier
hi def link pInvalidRelease Error
hi def link pRelease Comment

hi def link shellCmd MoreMsg
"hi def link validPython3Path MoreMsg
hi def link invalidPython3Path Error
