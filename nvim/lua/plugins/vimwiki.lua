vim.g.vimwiki_list = {
  {
    path = '~/vimwiki/',
    syntax = 'markdown',
    ext = '.md',
    custom_wiki2html = '$GOPATH/bin/vimwiki-godown',
    custom_wiki2html_args = 'vimwiki/'
  }
}
