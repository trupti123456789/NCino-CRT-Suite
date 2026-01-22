from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import os

@library
class UploadFile:

    @keyword("Custom Upload File")
    def custom_upload_file(self, file_path, file_input_xpath, upload_button_xpath=None):

        if not os.path.exists(file_path):
            raise Exception(f"File not found: {file_path}")

        if upload_button_xpath:
            BuiltIn().run_keyword("Click Element", upload_button_xpath)

        BuiltIn().run_keyword("Choose File", file_input_xpath, file_path)
