import pdb

# from colorama import Fore, Back, Style
# STYLE_MAIN = f'{Fore.GREEN}{Back.WHITE}{Style.DIM}'
# STYLE_END = f'{Fore.WHITE}{Back.RESET}{Style.NORMAL}'
# prompt = f'{STYLE_MAIN} PDB++{STYLE_END}{Style.RESET_ALL}'

# alias emb from IPython import embed; embed()


class Config(pdb.DefaultConfig):
    prompt = f' PDB++❱ '
    pygments_formatter_class = 'pygments.formatters.TerminalTrueColorFormatter'
    pygments_formatter_kwargs = {'style': 'solarized-dark'}
