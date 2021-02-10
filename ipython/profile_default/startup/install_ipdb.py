# If ipdb is installed, register it as the default debugger
try:
    import ipdb
    import os
    os.environ['PYTHONBREAKPOINT'] = 'ipdb.set_trace'
except ImportError:
    pass
