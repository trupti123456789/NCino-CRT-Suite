# file: attach_selenium.py
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary import SeleniumLibrary

def attach_driver():
    qweb_driver = BuiltIn().get_library_instance("QWeb").driver
    selib = BuiltIn().get_library_instance("SeleniumLibrary")
    selib.register_driver(qweb_driver, "default")
