# Package automation contains the Cloud Function code to automate actions.

# Copyright 2019 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# 	https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
resource "google_service_account" "automation-service-account" {
  account_id   = "automation-service-account"
  display_name = "Service account used by automation Cloud Function"
  project      = "${var.automation-project}"
}

resource "google_service_account_key" "cloudfunction-key" {
  service_account_id = "${google_service_account.automation-service-account.name}"
}

resource "local_file" "cloudfunction-key-file" {
  content  = "${base64decode(google_service_account_key.cloudfunction-key.private_key)}"
  filename = "./automation/auth.json"
}
