from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import os

@library
class UploadFile:

    @keyword("Upload File")
    def upload_file(self, file_input_xpath, file_path, upload_button_xpath=None):

        if not os.path.exists(file_path):
            raise Exception(f"File not found: {file_path}")

        if upload_button_xpath:
            BuiltIn().run_keyword("Click Element", upload_button_xpath)

        BuiltIn().run_keyword("Choose File", file_input_xpath, file_path)
