Enable Clipboard & Drag-Drop (VirtualBox Settings)

------------------------------
- Right-click VM → Settings
- General → Advanced
- Shared Clipboard → Bidirectional
- Drag’n Drop → Bidirectional
------------------------------

```
sudo apt update
```

```
sudo apt install build-essential dkms linux-headers-$(uname -r) -y
```

Click "Devices" & Insert Guest additions CD Images

<img width="1064" height="624" alt="image" src="https://github.com/user-attachments/assets/5db1a864-b658-4e83-9322-9d06d553304b" />

```
sudo bash /media/$USER/VBox_GAs_*/VBoxLinuxAdditions.run
```

```
sudo reboot
```
