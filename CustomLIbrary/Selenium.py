from SeleniumLibrary.base import LibraryComponent, keyword
from collections import namedtuple
from typing import List, Optional, Tuple, Union
from SeleniumLibrary.utils import is_noney
from robot.utils import plural_or_not, is_truthy
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.webelement import WebElement

from SeleniumLibrary.base import LibraryComponent,keyword
from SeleniumLibrary.errors import ElementNotFound
from SeleniumLibrary.utils.types import type_converter
import os

class selenium(LibraryComponent):

    @keyword
    def upload_file_lightning(self, locator, file_path):
        if not os.path.exists(file_path):
            raise Exception(f"File not found: {file_path}")

        element = self.find_element(locator)
        element.send_keys(file_path)
