import requests
import os
from dotenv import load_dotenv
import time

# Load environment variables from .env file
load_dotenv()

BASE_URL = "https://xray.cloud.getxray.app/api/v2"
CLIENT_ID = "E577F9CAEC8A4171985D2F82F129D73F"
CLIENT_SECRET = "fe3003afe6ef037751c6e1f8321f8145f9f01b274b0ab43bbb609aad7759957a"
AUTH_TOKEN = None
TOKEN_EXPIRY = 0

def authenticate():
    global AUTH_TOKEN, TOKEN_EXPIRY
    auth_url = f"{BASE_URL}/authenticate"
    response = requests.post(
        auth_url,
        json={"client_id": CLIENT_ID, "client_secret": CLIENT_SECRET}
    )
    if response.status_code == 200:
        AUTH_TOKEN = response.json().strip('"')  # Remove quotes from token
        TOKEN_EXPIRY = time.time() + 3500  # 10s buffer before expiry
        print(f"Authentication successful. Token: {AUTH_TOKEN[:20]}...")  # Debug
    else:
        raise Exception(f"Xray auth failed: {response.status_code} - {response.text}")

def get_auth_header():
    global AUTH_TOKEN, TOKEN_EXPIRY
    if not AUTH_TOKEN or time.time() > TOKEN_EXPIRY:
        authenticate()
    return {
        "Authorization": f"Bearer {AUTH_TOKEN}",
        "Content-Type": "application/xml"  # Must match curl
    }

def import_robot_results(output_xml_path, project_key=None, test_exec_key=None):
    """
    Matches the curl command structure:
    curl -X POST \
      -H "Authorization: Bearer ..." \
      -H "Content-Type: application/xml" \
      --data @output.xml \
      "https://xray.../robot?projectKey=POEI25"
    """
    headers = get_auth_header()
    url = f"{BASE_URL}/import/execution/robot?projectKey=POEI25"
    
    # Build query parameters
    params = {}
    if project_key:
        params["projectKey"] = project_key
    if test_exec_key:
        params["testExecKey"] = test_exec_key
    
    try:
        with open(output_xml_path, 'rb') as xml_file:
            # Read file content for error reporting
            file_content = xml_file.read()
            
            # Prepare the request for debugging
            req = requests.Request(
                'POST',
                url,
                headers=headers,
                params=params,
                data=file_content
            ).prepare()
            
            # Print debug info (similar to curl -v)
            print(f"\nSending request to: {req.url}")
            print(f"Headers: {req.headers}")
            print(f"Body size: {len(file_content)} bytes")
            
            # Send request
            response = requests.Session().send(req)
            
            # Debug response
            print(f"Response: {response.status_code} - {response.text[:200]}...")
            
            response.raise_for_status()
            return response.json()
            
    except Exception as e:
        # Build detailed error message
        error_msg = (
            f"Xray import failed\n"
            f"Error: {str(e)}\n"
            f"URL: {url}\n"
            f"Params: {params}\n"
            f"Headers: {headers}\n"
            f"File: {output_xml_path} ({len(file_content) if 'file_content' in locals() else 'missing'})"
        )
        raise Exception(error_msg) from e
