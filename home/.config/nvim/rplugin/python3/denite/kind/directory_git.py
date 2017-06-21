import re
import os
from itertools import filterfalse

from .openable import Kind as Openable


class Kind(Openable):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'directory_git'
        self.default_action = 'open'

    def action_open(self, context):
        cwd = self.vim.call('getcwd')
        target = context['targets'][0]
        path = re.sub(r'.git', '', target['action__path'])

        self.vim.command('lcd {}'.format(path))
        self.vim.call('denite#util#execute_path', 'edit', path)



