let s:suite  = themis#suite('ibm_bluemix')
let s:assert = themis#helper('assert')

function! s:suite.before_each() abort "{{{
    let g:ibm_bluemix#config = {
    \    'username': 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
    \    'password': 'xxxxxxxxxxxx',
    \    'source': 'ja',
    \    'target': 'en',
    \    'strict': 0,
    \ }
endfunction "}}}

function! s:suite.checkLangJa() abort "{{{
    call s:assert.equals(ibm_bluemix#checkLang('I use Vim.'),      {'target': 'ja', 'source': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('I''m Vimmer!'),    {'target': 'ja', 'source': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('Are you Vimmer?'), {'target': 'ja', 'source': 'en'})
endfunction "}}}

function! s:suite.checkLangEn() abort "{{{
    call s:assert.equals(ibm_bluemix#checkLang('私はVimを使います。'),   {'source': 'ja', 'target': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('私はVimmerです!'),       {'source': 'ja', 'target': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('あなたはVimmerですか?'), {'source': 'ja', 'target': 'en'})
endfunction "}}}

function! s:suite.checkLangStrict() abort "{{{
    let g:ibm_bluemix#config.strict = 1

    call s:assert.equals(ibm_bluemix#checkLang('I use Vim.'),      {'source': 'ja', 'target': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('I''m Vimmer!'),    {'source': 'ja', 'target': 'en'})
    call s:assert.equals(ibm_bluemix#checkLang('Are you Vimmer?'), {'source': 'ja', 'target': 'en'})
endfunction "}}}
