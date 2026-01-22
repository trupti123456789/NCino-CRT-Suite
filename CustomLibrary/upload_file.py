from robot.api.deco import library, keyword
from selenium.webdriver.common.by import By
import os

@library
class UploadFile:

    @keyword("Upload File Using Driver")
    def upload_file_using_driver(self, driver, file_path, upload_button_xpath=None):
        """
        Upload file using driver passed from Robot

        Arguments:
        - driver : WebDriver instance from CRT
        - file_path : Absolute file path
        - upload_button_xpath (optional) : XPath of upload button
        """

        if not os.path.exists(file_path):
            raise Exception(f"File not found: {file_path}")

        if upload_button_xpath:
            driver.find_element(By.XPATH, upload_button_xpath).click()

        file_input = driver.find_element(By.XPATH, "//input[@type='file']")
        file_input.send_keys(file_path)
