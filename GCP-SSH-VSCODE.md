### SSH into GCP instance using vscode:

## Instructions
IMPORTANT: These instructions are to ssh to the vms from start to finish. If you've successfully built the infrastructure using terraform
then you'll start at the final output command for linux, and step 4 for windows.

# Connect via ssh for Mac OS and Linux:
1. install vscodes remote ssh module. 
2. generate a key
ssh-keygen -t rsa -f <path> -C <username> -b 2048 

That should look something like this:
ssh-keygen -t rsa -f ~/.ssh/dtproducer -C <rfilgas> -b 2048 

3. cat your public key
cat ~/.ssh/dtproducer.pub
3. Go to your vm instance. Make sure it isn't running. Edit. Go down to ssh keys. Copy in your public key. Save. Run the vm.
4. There should be a new icon to the left in vscode called remote explorer. Hit the + button to add.
5. Use your info to login.
// get the ip address from the vm. To do this go to the page where you can see all of your vms. Copy the external ip!
// get the path to your private key from the .ssh directory. Plug them in below.
ssh -i <path to private key> <username>@<external ip address> -A

Note: If your ip switches, open the ssh doc from the vscode connection module and replace the ip address manually.


Connect via ssh for WINDOWS

1. Install vscodes remote ssh module
2. Generate a key by first navigating to Users\<username>\.ssh, then running in powershell: ssh-keygen.exe
3. Make sure to add a password, and name the file whatever you like.
4. Navigate to the files parent folder in window explorer. Right click on the .ssh folder and select properties.
5. Click on the security tab. Click advanced. Remove all permissions except for specifically your username. If prompted about inheritance, you DONT want it. Go into each tab and if it has inheritance as an option, turn it off. Click apply and ok until the settings windows are closed.
6. Repeat this securities process on your <id_rsa.pub> and <id_rsa> files.
7. Go to your gcp instance, click the equivalent of "add an ssh key" and add the contents of the <id_rsa.pub> file. Click save!
8. Get your external ip address in google cloud by navigating to compute>instances and copying the external ip.
9. On the left panel in vscode, go to the remote ssh icon. Click the button to add.
10. In the prompt that pops up type: <your_username>@ip_address
11. It's not going to work. This is expected. Click the gear icon and select the config file you saved your ssh info to open.
12. Make sure your username here EXACTLY matches your username on the vm.
13. Add one more line to the bottom of this config file: IdentityFile ~/.ssh/<id_rsa>
14. Connect. You're officially done! Click "open folder" and select the filepath to your project.

Note:  If your ip switches, open the ssh doc from the vscode connection module and replace the ip address manually wherever it occurs in the file.
TODO: Refine windows directions as some steps could likely be simplified.