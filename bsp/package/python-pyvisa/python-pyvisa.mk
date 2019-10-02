################################################################################
#
# python-pyvisa
#
################################################################################

PYTHON_PYVISA_VERSION = 1.10.0
PYTHON_PYVISA_SOURCE = PyVISA-$(PYTHON_PYVISA_VERSION).tar.gz
PYTHON_PYVISA_SITE = https://files.pythonhosted.org/packages/01/c2/659f257f4d97ac0e519c733c98c27fc981ae5b5adb525411f7bb9c044483
PYTHON_PYVISA_SETUP_TYPE = setuptools
PYTHON_PYVISA_LICENSE = MIT
PYTHON_PYVISA_LICENSE_FILES = LICENSE

$(eval $(python-package))
