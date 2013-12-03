# install the apport exception handler if available
try:
    import apport_python_hook
except ImportError:
    pass
else:
    apport_python_hook.install()

# Workaround for rdiff-backup bug http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=587370
import warnings
warnings.simplefilter("ignore", DeprecationWarning)
