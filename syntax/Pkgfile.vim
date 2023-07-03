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

syn match pDescription /^# Description:/ contained
syn match pValidDescription /[[:alnum:]\s#,\-'].\{16,79}/ contained contains=pDescription
syn match pInvalidDescription /[^[:alnum:]\s#\-,']\|.\{80,}/ contained contains=pValidDescription,pDescription
syn match pDescriptionGroup /^# Description:.*$/ contains=pValidDescription,pInvalidDescription,pDescription

syn match pValidURL /\(https\|http\|ftp\)\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contained
syn match pInvalidURL /\(\(?!^\(https\|http\|ftp\)\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*$\)\_.\)*/ contained contains=pValidURL
syn match pURLGroup /^# URL:.*$/ contains=pValidURL,pInvalidURL

syn match pMaintainer /^# Maintainer:/ contained
syn match pValidMaintainer /\([[:alnum:],'\-#:\n ]\)/ contained contains=pMaintainer
syn match pInvalidMaintainer /\(@\|.\)/ contained contains=pValidMaintainer,pMaintainer
syn match pMaintainerGroup /^# Maintainer:.*$/ contains=pMaintainer,pValidMaintainer,pInvalidMaintainer

syn match pDependsOn /^# Depends on:/ contained
syn match pValidDependsOn /\([[:alnum:]#:\- ]\)/ contained contains=pDependsOn
syn match pInvalidDependsOn /\([^[:alnum:]#:\- ]\)/ contained contains=pValidDependsOn,pDependsOn
syn match pDependsOn /^# Depends on:.*$/ contains=pValidDependsOn,pInvalidDependsOn,pDependsOn

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

syn clear shStatement
syn keyword shStatement alias break cd chdir continue eval exec exit kill newgrp pwd read readonly return shift test trap ulimit umask wait
syn keyword shStatement bg builtin disown export false fg getopts jobs let printf sleep true unalias typeset fc hash history suspend times type bind builtin caller compopt declare dirs disown enable export help logout mapfile popd pushd readarray shopt typeset

syn match pSource /^source=/ contained
syn match pValidSource /[a-zA-Z0-9\-.]/ contained contains=pSource
syn match pInvalidSource /\(http\|ftp\|https\).*\.\+\(dl\|download.\?\)\.\(sourceforge\|sf\).net/ contained contains=pSource,pValidSource
syn match pDerefEmulation /\$[{]\?[[:alnum:]_]*[}]\?/ contained
syn region pSourceRegion start=/(/ end=/)/ contains=pSource,pInvalidSource,pDerefEmulation
syn match pSourceGroup /^source=.*/ contains=pValidSource,pInvalidSource,pSourceRegion,pSource

hi def link pValidDescription Identifier
hi def link pInvalidDescription Error
"hi def link pDescriptionGroup DiagnosticWarn
hi def link pDescription Comment

hi def link pValidURL Identifier
hi def link pInvalidURL Error
hi def link pURLGroup Comment

hi def link pValidMaintainer Identifier
hi def link pInvalidMaintainer Error
hi def link pMaintainer Comment

hi def link pValidDependsOn Identifier
hi def link pInvalidDependsOn Error
hi def link pDependsOn Comment

hi def link pValidName Identifier
hi def link pInvalidName Error
hi def link pName Comment

hi def link pValidVersion Identifier
hi def link pInvalidVersion Error
hi def link pVersion Comment

hi def link pValidRelease Identifier
hi def link pInvalidRelease Error
hi def link pRelease Comment

hi def link pInvalidSource Error
hi def link pSource Comment
hi def link pDerefEmulation PreProc
