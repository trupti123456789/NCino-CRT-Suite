from robot.api.deco import library, keyword
from selenium.webdriver.common.by import By
import os

@library
class UploadFile:

    def __init__(self, driver=None):
        self.driver = driver

    def _find_project_root_with_data(self):
        """
        Traverse upward to find folder containing 'Data'
        """
        current_dir = os.path.dirname(os.path.abspath(__file__))

        while True:
            data_path = os.path.join(current_dir, "Data")
            if os.path.isdir(data_path):
                return current_dir

            parent_dir = os.path.dirname(current_dir)
            if parent_dir == current_dir:
                break

            current_dir = parent_dir

        raise Exception("Data folder not found in project hierarchy")

    @keyword("Upload File From Data Folder")
    def upload_file_from_data_folder(self, file_name, upload_button_xpath=None):
        
        # 🔹 Build full file path
        full_path = os.path.join(self.project_root, "Data", file_name)

        # 🔹 Validate file existence
        if not os.path.exists(full_path):
            raise Exception(f"File not found in Data folder: {full_path}")

        # 🔹 Click upload button if provided
        if upload_button_xpath:
            self.driver.find_element(By.XPATH, upload_button_xpath).click()

        # 🔹 Locate input[type='file']
        file_input = self.driver.find_element(By.XPATH, "//input[@type='file']")

        # 🔹 Upload file
        file_input.send_keys(full_path)
