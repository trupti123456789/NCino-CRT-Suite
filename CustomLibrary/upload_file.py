from robot.api.deco import library, keyword
from selenium.webdriver.common.by import By
import os

@library
class UploadFile:

    def __init__(self, driver=None):
        self.driver = driver

    @keyword("Upload File Using Full Path")
    def upload_file_using_full_path(self, file_path, upload_button_xpath=None):
        """
        Upload file using absolute path resolved by Robot

        Args:
        file_path : Full absolute file path
        upload_button_xpath (optional) : XPath of upload button
        """

        if not os.path.exists(file_path):
            raise Exception(f"File not found: {file_path}")

        if upload_button_xpath:
            self.driver.find_element(By.XPATH, upload_button_xpath).click()

        file_input = self.driver.find_element(By.XPATH, "//input[@type='file']")
        file_input.send_keys(file_path)
