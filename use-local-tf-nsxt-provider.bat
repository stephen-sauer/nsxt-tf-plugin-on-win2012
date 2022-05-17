@ECHO OFF 
:: This batch file details nsxt plugin install to use locally with terraform on Windows2012.
TITLE Deploy NSXT Provider locally
ECHO Please wait... Creating Target directory
mkdir C:\Users\Administrator\AppData\Roaming\terraform.d\plugins\terraform.local\local\nsxt\3.2.6\windows_amd64\
ECHO ==========================
ECHO Plugin Directory created
ECHO ==========================
ECHO Please wait... Unzipping NSX-T Provider and copying to dest Directory
unzip terraform-provider-nsxt_3.2.6_windows_amd64.zip
copy terraform-provider-nsxt_v3.2.6.exe C:\Users\Administrator\AppData\Roaming\terraform.d\plugins\terraform.local\local\nsxt\3.2.6\windows_amd64\
ECHO ==========================
ECHO Plugin sent to dest
ECHO ==========================

ECHO Please wait... Creating terraform.rc file
copy terraform.rc C:\Users\Administrator\AppData
ECHO ==========================
ECHO terraform.rc created and added to AppData
ECHO ==========================

ECHO Please wait... Creating a test directory for terraform
mkdir C:\Users\Administrator\tftemp
copy main.tf C:\Users\Administrator\tftemp
copy terraform.tfvars C:\Users\Administrator\tftemp
copy variables.tf C:\Users\Administrator\tftemp
ECHO ==========================
ECHO "Temp Directory and files added: C:\Users\Administrator\tftemp"
ECHO ==========================
cd C:\Users\Administrator\tftemp
terraform init -no-color
pause
