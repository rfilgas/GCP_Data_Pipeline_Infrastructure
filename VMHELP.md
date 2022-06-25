### Troubleshooting Virtual Machines:

Steps to follow if you lose access to your GCP vm because of a full hard drive.

1. Make a snapshot of the vm to save the data in case you mess something up.
2. Make sure you have another vm you can access up and running. We'll use this later.
3. Click edit on the extra full vm that you can't access and make sure it's stopped first. Half way down the page, disconnect the main disk. Thankfully there's a backup, otherwise this might be scary.
4. Click edit on the vm you have access to. Half way down the page connect the disk from the old vm as an extra disk to the accessible vm.
5. SSH into the accessible vm.
6. Display available disks by running this in the terminal:  lsblk
7. Make a directory for the disk you just connected. This is where we will mount it: sudo mkdir -p /<data-mount>
8. Mount the disk. Replace sdb 1 with the relevant name:  sudo mount -o discard,defaults /dev/<sdb1> /<data-mount>
9. Access your disk. In my case I used cyberduck to copy down files and deleted old ones in the disk to free up space.
10. Unmount the disk: sudo umount /<data-mount>
11. Stop your accessible instance, click edit for the instance and disconnect the disk. Clean up residual files and resources.
12. Connect the disk to its original instance as the boot drive.
13. SSH into your previously too full instance. It should be accessible now that you've cleaned out the files.
14. Celebrate!