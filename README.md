# nsxt-tf-plugin-on-win2012

## Disclaimer

   > THE DEVELOPER WORK'S PRODUCT IS PROVIDED “AS IS” WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED, INCLUDING WITHOUT ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT.


  >  The installation steps described in this document are restricted to development environments only and must not be used in production environments.


  >  The installation steps described in this document has been tested on Win2012R2 with terraform plugin 3.2.6.**

  >  In case you want to use it in another Windows OS, you will have to adapt this procedure if this procedure is not working**

> Key points:

>    Directory where terraform.rc has to be deployed -> See terraform documentation: https://www.terraform.io/cli/config/config-file*
>    Directory where terraform plugin has to be deployed -> You need to create a directory in your %APPDATA%*


## Overview and Use Case

Using a local Terraform Provider in a Windows Server (example with a Win2012R2 and nsxt provider).

### Use Case: 
>You need to use Terraform Provider in a AirGap environment. In this case, you have to use local providers in your environment. 

When using a Linux machine to use Terraform and local providers, the documentation is pretty clear. 

If you have to use Windows machine some clarifications are required. Especially concerning the directory where the providers/plugins have to be stored and used. 


## Deployment Example

**What do you need ?**

- The provider executable and its version. In this example, we're using the nsxt terraform plugin version 3.2.6
    
     The exe can be found in the github page     
     [https://github.com/vmware/terraform-provider-nsxt/releases/tag/v3.2.6](https://github.com/vmware/terraform-provider-nsxt/releases/tag/v3.2.6)

**Go to your windows machine and download the version suited to your environment.**

- Picking this one in our example: terraform-provider-nsxt_3.2.6_windows_amd64.zip

**Let’s create the directory where we’re going to put the exe provider**

- Assuming you’re connected as Administrator on your Win2012R2, then your main directory should be C:/Users/Administrator/
```
   mkdir C:\Users\Administrator\AppData\Roaming\terraform.d\plugins\terraform.local\local\nsxt\3.2.6\windows_amd64\
```
    
- ***If not using the provider in this example, adapt the path based on the downloaded provider -> Change the version, the OS…***

**Extract the files from the zip file and copy the terraformxxx.exe to the created directory**

```
copy terraform-provider-nsxt_v3.2.6.exe C:\Users\Administrator\AppData\Roaming\terraform.d\plugins\terraform.local\local\nsxt\3.2.6\windows_amd64\*
```
  
**You need to add a terraform.rc file to init your terraform CLI with the correct value for this provider**

- Create a terraform.rc file under C:\Users\Administrator\AppData\ directory

  *See the provided terraform.rc example. You will have to adapt it to your needs.*

  In this example, ALL the providers requests will be redirect to the local directory indicated in the terraform.rc.

**Now, in the directory you plan to use to provision an environment**, add this to your « main.tf » file
``` bash
terraform {
  required_providers {
    nsxt = {
      source  = "terraform.local/local/nsxt"
      version = "3.2.6"
    }
  }
}
```

**When doing ***terraform init***, you will see it’s using the local provider and not a remote location**

![TF INIT](/tf-init.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
