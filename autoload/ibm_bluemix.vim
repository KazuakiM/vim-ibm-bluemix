" https://www.ibm.com/watson/developercloud/language-translator/api/v2/

let s:save_cpo = &cpo
set cpo&vim

"variable {{{
if !exists('g:ibm_bluemix#config.username')    ||
    \ !exists('g:ibm_bluemix#config.password') ||
    \ !exists('g:ibm_bluemix#config.source')   ||
    \ !exists('g:ibm_bluemix#config.target')
    echohl ErrorMsg | echomsg "vim-ibm_bluemix: require 'g:ibm_bluemix#config = {'username','password', 'source', 'target'}" | echohl None
    finish
endif
let g:ibm_bluemix#config.strict = !has_key(g:ibm_bluemix#config, 'strict') ? 0 : g:ibm_bluemix#config.strict

let s:V = vital#ibm_bluemix#new()
let s:HTTP = s:V.import('Web.HTTP')
"}}}

function! ibm_bluemix#request(text, convert) abort "{{{
    return s:HTTP.request({
    \    'url': 'https://gateway.watsonplatform.net/language-translator/api/v2/translate',
    \    'method': 'POST',
    \    'data': json_encode({
    \        'text': a:text,
    \        'source': a:convert.source,
    \        'target': a:convert.target
    \    }),
    \    'headers': {'Accept': 'application/json'},
    \    'contentType': 'application/json',
    \    'username': g:ibm_bluemix#config.username,
    \    'password': g:ibm_bluemix#config.password
    \})
endfunction "}}}

function! ibm_bluemix#checkLang(text) abort "{{{
    let l:ret = {
    \    'target': g:ibm_bluemix#config.target,
    \    'source': g:ibm_bluemix#config.source
    \}

    if g:ibm_bluemix#config.target ==# 'en' && g:ibm_bluemix#config.strict ==# 0
        for l:index in range(len(a:text))
            if match(a:text[l:index], "[\'\?\!\.\,\ 0-9A-Za-z_]") ==# -1
                return l:ret
            endif
        endfor
        return {
        \    'target': g:ibm_bluemix#config.source,
        \    'source': g:ibm_bluemix#config.target
        \}
    endif
    return l:ret
endfunction "}}}

function! ibm_bluemix#execute(...) abort "{{{
    let l:text = join(a:000)
    if len(l:text) ==# 0
        let l:text = expand('<cword>')
        if len(l:text) ==# 0
            return
        endif
    endif

    let l:convert = ibm_bluemix#checkLang(l:text)

    let l:response = ibm_bluemix#request(l:text, l:convert)
    if len(l:response) ==# 0 || l:response.status !=# 200
        echohl ErrorMsg | echomsg "vim-ibm_bluemix: request error." | echohl None
    endif

    let l:content = json_decode(l:response.content)
    if 0 < len(l:content.translations)
        let l:return = l:content.translations
        if l:convert.source !=# g:ibm_bluemix#config.source
            call add(l:return, "\nWARNING: This translate is swapped \"source\" and \"target\".\n\n\tYou can execute strict mode.\n\tg:ibm_bluemix#config.strict = 1")
        endif
        cgetexpr join(l:return, "\n")
        copen
    endif
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo
